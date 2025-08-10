import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  final Map<int, Stopwatch> _stopwatches = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final key = options.uri.hashCode;

    // 기존 Stopwatch가 있으면 정리 후 다시 실행 (중복 방지)
    _stopwatches[key]?.stop();
    _stopwatches[key]?.reset();
    _stopwatches[key] = Stopwatch()..start();

    log('[요청] ${options.method} ${options.uri}');

    if (options.queryParameters.isNotEmpty) {
      log('쿼리 파라미터: ${_safeJsonEncode(options.queryParameters)}');
    }

    if (options.data != null) {
      log('데이터: ${_safeJsonEncode(options.data)}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final key = response.requestOptions.uri.hashCode;
    _logResponse(
      statusCode: response.statusCode,
      url: response.requestOptions.uri.toString(),
      responseData: response.data,
      key: key,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final key = err.requestOptions.uri.hashCode;
    _logResponse(
      statusCode: err.response?.statusCode,
      url: err.requestOptions.uri.toString(),
      responseData: err.response?.data,
      key: key,
      isError: true,
    );

    log('에러: ${err.message ?? "No error message"}');

    if (err.stackTrace != null) {
      log('Stack Trace: ${_truncateText(err.stackTrace.toString(), maxLines: 5)}');
    }

    handler.next(err);
  }

  void _logResponse({
    int? statusCode,
    required String url,
    dynamic responseData,
    required int key,
    bool isError = false,
  }) {
    final stopwatch = _stopwatches.remove(key);
    final elapsed = stopwatch?.elapsedMilliseconds ?? -1;
    final emoji = _getStatusEmoji(statusCode, isError, elapsed);

    log('$emoji ${statusCode ?? "N/A"} | ${elapsed >= 0 ? '$elapsed ms' : 'Too Fast'} | $url');

    if (responseData != null) {
      log('Response Data: ${_safeJsonEncode(responseData)}');
    }
  }

  /// HTTP 상태 코드별 이모지 반환
  String _getStatusEmoji(int? statusCode, bool isError, int elapsed) {
    if (isError) return '❌';
    if (statusCode == null) return '❓';
    if (elapsed < 100) return '⚡ Ultra Fast'; // 100ms 미만 응답
    if (elapsed < 200) return '⚡ Fast Response'; // 100~200ms 응답
    if (statusCode >= 200 && statusCode < 300) return '✅';
    if (statusCode >= 300 && statusCode < 400) return '🟠';
    return '❌';
  }

  /// JSON 데이터 정리 (길이 제한 포함)
  String _safeJsonEncode(dynamic data) {
    try {
      if (data is FormData) return '📂 FormData (not printable)';
      return _truncateText(jsonEncode(data), maxLength: 100);
    } catch (_) {
      return _truncateText(data.toString(), maxLength: 100);
    }
  }

  /// 문자열 길이 제한 (길면 생략)
  String _truncateText(String text, {int maxLength = 100, int maxLines = 3}) {
    final lines = text.split('\n');
    if (lines.length > maxLines) {
      return '${lines.take(maxLines).join('\n')}\n... (truncated)';
    }
    return text.length > maxLength ? '${text.substring(0, maxLength)}... (truncated)' : text;
  }
}