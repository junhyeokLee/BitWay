import 'dart:developer';
import 'package:dio/dio.dart';
import 'LoggerInterceptor.dart'; // 기존 로깅 인터셉터를 상속받음

class SafeLoggerInterceptor extends LoggerInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sanitizedHeaders = {...options.headers}; // 원본 헤더 복사하여 수정
    if (sanitizedHeaders.containsKey('Authorization')) {
      sanitizedHeaders['Authorization'] = 'Bearer ***'; // 토큰 마스킹
    }

    final sanitizedData = options.data?.toString().replaceAll(RegExp(r'\w'), '*');

    log('Request Headers: $sanitizedHeaders');
    log('Request Data: $sanitizedData');

    super.onRequest(options, handler);
  }
}
