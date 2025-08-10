// lib/common/error_handling.dart

import 'package:dio/dio.dart';

String getErrorMessage(Object error) {
  if (error is DioException) {
    // DioError인 경우
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          return '잘못된 요청입니다. 요청을 다시 확인해주세요.';
        case 401:
          return '인증이 필요합니다. 로그인 후 다시 시도하세요.';
        case 403:
          return '접근이 금지되었습니다.';
        case 404:
          return '요청한 데이터를 찾을 수 없습니다.';
        case 429:
          return '요청이 너무 많습니다. 잠시 후 다시 시도해주세요.';
        case 500:
          return '서버 오류가 발생했습니다. 나중에 다시 시도해주세요.';
        default:
          return '알 수 없는 오류가 발생했습니다.';
      }
    } else {
      return '네트워크 오류가 발생했습니다. 인터넷 연결을 확인해주세요.';
    }
  } else {
    // DioError가 아닌 경우
    return '${error.toString()}';
  }
}