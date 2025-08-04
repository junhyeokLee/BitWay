import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<DioClient>((ref) => DioClient());

class DioClient {
  static final DioClient _singleton = DioClient._internal();  // 1. 정적 인스턴스 생성
  static DioClient get instance => _singleton;
  late final Dio dio;

  factory DioClient() => _singleton;

  DioClient._internal() {
    final options = BaseOptions(
      baseUrl: 'https://your-api-url.com', // 여기에 실제 서버 URL 입력
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    );

    dio = Dio(options);

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ));
    }

    // 인증 관련 인터셉터 추후 추가 가능
    // dio.interceptors.add(AuthInterceptor());
  }
}