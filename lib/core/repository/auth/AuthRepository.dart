import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as dio;
import 'package:bitway/core/storage/StorageKeys.dart';

class AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  AuthRepository(this._dio);

  Future<void> sendEmailVerificationCode(String email) async {
    try {
      await _dio.post('/auth/email/send-code', data: {'email': email});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyEmailCode(String email, String code) async {
    try {
      await _dio.post('/auth/email/verify-code', data: {
        'email': email,
        'code': code,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String nickname,
    required List<String> favoriteCoins,
    required bool agreeTerms,
    required bool agreePrivacy,
    required bool agreeMarketing,
  }) async {
    try {
      await _dio.post('/auth/signup', data: {
        'email': email,
        'password': password,
        'nickname': nickname,
        'favoriteCoins': favoriteCoins,
        'agreeTerms': agreeTerms,
        'agreePrivacy': agreePrivacy,
        'agreeMarketing': agreeMarketing,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      // 예시: 성공 여부를 response.statusCode 또는 특정 응답 필드로 판단
      if (response.statusCode == 200) {
        // 예: accessToken 저장 등 처리
        final accessToken = response.data['accessToken'];
        // TODO: SharedPreferences 등을 사용해 저장
        return true;
      }

      return false;
    } catch (e) {
      // 로그 출력 또는 예외 처리 가능
      return false;
    }
  }

  Future<(bool, String?, Map<String, dynamic>?)> refreshToken(String email, String refreshToken, String deviceId) async {
    try {
      final response = await _dio.post('/api/auth/reissue', data: {
        "email": email,
        "refreshToken": refreshToken,
        "deviceId": deviceId
      });

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>?;
        final accessToken = data?['accessToken'] as String?;
        final newRefreshToken = data?['refreshToken'] as String?;
        if (accessToken != null && newRefreshToken != null) {
          await storage.write(key: StorageKeys.accessToken, value: accessToken);
          await storage.write(key: StorageKeys.refreshToken, value: newRefreshToken);
        }
        return (true, null, data);
      } else {
        final String? msg = response.data['msg']?.toString() ?? '토큰 갱신 실패';
        return (false, msg, null);
      }
    } catch (e) {
      debugPrint('토큰 갱신 에러: $e');
      return (false, '서버 통신 중 오류 발생', null);
    }
  }

}