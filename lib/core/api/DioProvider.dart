import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interceptors/AuthInterceptor.dart';
import 'interceptors/NetworkCheckerInterceptor.dart';
import 'interceptors/RetryInterceptor.dart';
import 'interceptors/SafeLoggerInterceptor.dart';


// final loggerInterceptorProvider = Provider((ref) => LoggerInterceptor());
final safeLoggerInterceptorProvider = Provider((ref) => SafeLoggerInterceptor());
final networkCheckerInterceptorProvider = Provider((ref) => NetworkCheckerInterceptor());
final retryInterceptorProvider = Provider.family<RetryInterceptor, Dio>((ref, dio) {return RetryInterceptor(dio: dio);});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
  baseUrl: 'http://192.168.35.142:8080',
        // 192.168.35.142
  connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  //  Interceptors를 Provider에서 가져와 안전하게 주입 (addAll로 변경하여 코드 정리)
  dio.interceptors.addAll([
    // ref.read(loggerInterceptorProvider),
    ref.read(safeLoggerInterceptorProvider),
    ref.read(networkCheckerInterceptorProvider),
    ref.read(retryInterceptorProvider(dio)),  // Dio 인스턴스 필요
    AuthInterceptor(dio, onTokenExpired: () async {
      final storage = FlutterSecureStorage();
      // await storage.delete(key: StorageKeys.email);
      // await storage.delete(key: StorageKeys.username);
      // await storage.delete(key: StorageKeys.nickname);
      // await storage.delete(key: StorageKeys.phoneNumber);
      // await storage.delete(key: StorageKeys.myTeamId);
      // await storage.delete(key: StorageKeys.accessToken);
      // await storage.delete(key: StorageKeys.refreshToken);
      await storage.deleteAll(); //  로그아웃 처리 = 기기에 저장된 유저정보 삭제
    }),
  ]);

  return dio;
});

