import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio;

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
}