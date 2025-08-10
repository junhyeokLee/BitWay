import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../../data/auth/req/Signup.dart';


class SignupViewModel extends StateNotifier<Signup> {
  SignupViewModel() : super(const Signup());

  Future<bool> sendEmailCode(String email) async {
    state = state.copyWith(loading: true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        email: email,
        codeSent: true,
        loading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint('sendEmailCode error: $e');
      return false;
    }
  }

  Future<bool> verifyEmailCode(String code) async {
    state = state.copyWith(loading: true);
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        emailVerified: true,
        loading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint('verifyEmailCode error: $e');
      return false;
    }
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void reset() {
    state = const Signup();
  }

  void updateAgreement({
    required bool terms,
    required bool privacy,
    required bool marketing,
  }) {
    state = state.copyWith(
      agreeTerms: terms,
      agreePrivacy: privacy,
      agreeMarketing: marketing,
    );
  }

  Future<bool> submitSignup() async {
    state = state.copyWith(loading: true);
    try {
      // TODO: 여기에 실제 서버 회원가입 요청을 넣어야 함
      await Future.delayed(const Duration(seconds: 1));

      // 예시 토큰 저장 (실제 응답 사용)
      final token = 'fake-jwt-token';
      // Dio 클라이언트에 토큰 설정 등 추가 필요

      state = state.copyWith(loading: false);
      return true;
    } catch (e) {
      state = state.copyWith(loading: false);
      debugPrint('submitSignup error: $e');
      return false;
    }
  }
}