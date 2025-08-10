import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../repository/auth/AuthRepository.dart';
import '../../storage/StorageKeys.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio dio;
  Completer<void>? _refreshCompleter; // 토큰 갱신이 여러 번 발생하지 않도록 관리하는 Completer
  final Future<void> Function()? onTokenExpired; // 토큰 만료 시 로그아웃 처리 콜백

  AuthInterceptor(this.dio, {this.onTokenExpired});

  /// API 요청 전에 Access Token을 읽어 헤더에 추가하는 메서드
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final rawToken = await _storage.read(key: StorageKeys.accessToken);
    if (rawToken != null) {
      final token = rawToken.startsWith('Bearer ')
          ? rawToken.replaceFirst('Bearer ', '')
          : rawToken;
      options.headers['Authorization'] = 'Bearer $token';
      print('[AuthInterceptor] 요청 accessToken: $token');
    } else {
      print('[AuthInterceptor] 저장된 accessToken이 없습니다.');
    }
    return handler.next(options);
  }

  /// API 요청 중 401 또는 403 에러 발생 시, Access Token을 재발급하고 기존 요청을 재시도하는 메서드
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 Unauthorized 또는 403 Forbidden 에러 발생 시 토큰 갱신 진행
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      print('[AuthInterceptor] 401/403 에러 → 토큰 재발급 시도');
      if (_refreshCompleter == null) {
        _refreshCompleter = Completer();
        try {
          final email = await _storage.read(key: StorageKeys.email);
          final deviceId = await _storage.read(key: StorageKeys.fcmToken);
          final refreshToken = await _storage.read(key: StorageKeys.refreshToken);
          if (refreshToken == null) {
            // 리프레시 토큰이 없으면 즉시 로그아웃 처리
            print('[AuthInterceptor] refreshToken 없음 → 로그아웃');
            _refreshCompleter!.completeError('No refresh token');
            if (onTokenExpired != null) await onTokenExpired!();
            return handler.next(err);
          }
          // 새로운 Access Token 요청 (갱신 API 호출) via AuthRepository
          final authRepository = AuthRepository(dio);
          final result = await authRepository.refreshToken(email!, refreshToken, deviceId!);
          final success = result.$1;
          final errorMessage = result.$2;
          if (!success) {
            print('[AuthInterceptor] refreshToken 실패: $errorMessage');
            _refreshCompleter!.completeError(errorMessage ?? 'Token refresh failed');
            if (onTokenExpired != null) await onTokenExpired!();
            return handler.next(err);
          }
          else{
            print('[AuthInterceptor] 토큰 재발급 성공');
          }
          // 추가: 재발급 성공 시 반드시 저장
          final data = result.$3;
          final newAccessToken = data?['accessToken'] as String?;
          final newRefreshToken = data?['refreshToken'] as String?;
          if (newAccessToken != null && newRefreshToken != null) {
            print('[AuthInterceptor] 새로운 Access Token: $newAccessToken');
            print('[AuthInterceptor] 새로운 Refresh Token: $newRefreshToken');
            await _storage.write(key: StorageKeys.accessToken, value: newAccessToken);
            await _storage.write(key: StorageKeys.refreshToken, value: newRefreshToken);
          }
          // 토큰 재발급 후 재요청 시 newAccessToken 직접 사용
          try {
            final cleanToken = newAccessToken!.startsWith('Bearer ')
                ? newAccessToken.replaceFirst('Bearer ', '')
                : newAccessToken;
            print('[AuthInterceptor] 재요청 accessToken: $cleanToken');
            final retryResponse = await dio.request(
              err.requestOptions.path,
              options: Options(
                method: err.requestOptions.method,
                headers: {
                  ...err.requestOptions.headers,
                  'Authorization': 'Bearer $cleanToken',
                },
              ),
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );
            _refreshCompleter!.complete(); // 토큰 갱신 완료는 재요청 후에 호출
            return handler.resolve(retryResponse);
          } catch (e) {
            print('[AuthInterceptor] 실패 예외 발생: $e');
            _refreshCompleter!.completeError(e);
            return handler.next(err);
          }

        } catch (e) {
          print('[AuthInterceptor] 토큰 재발급 예외 발생: $e');
          _refreshCompleter!.completeError(e);
          if (onTokenExpired != null) await onTokenExpired!(); // 갱신 실패 시 로그아웃
          return handler.next(err);
        } finally {
          _refreshCompleter = null; // 갱신 완료 후 Completer 초기화
        }
      } else {
        try {
          // 토큰 갱신이 진행 중이면 기다렸다가 완료되면 기존 요청 재시도
          await _refreshCompleter!.future;
          final rawToken = await _storage.read(key: StorageKeys.accessToken);
          final token = rawToken?.startsWith('Bearer ') == true
              ? rawToken!.replaceFirst('Bearer ', '')
              : rawToken;
          print('[AuthInterceptor] 재요청 accessToken: $token');
          final retryResponse = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $token',
              },
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(retryResponse);
        } catch (e) {
          print('[AuthInterceptor] 재요청 중 예외 발생: $e');
          return handler.next(err);
        }
      }
    }

    return super.onError(err, handler);
  }
}
