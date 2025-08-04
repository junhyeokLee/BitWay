import 'package:freezed_annotation/freezed_annotation.dart';
part 'Signup.freezed.dart';

@freezed
class Signup with _$Signup {
  const factory Signup({
    @Default('') String email,
    @Default('') String password,
    @Default('') String nickname,
    @Default(false) bool emailVerified,
    @Default(false) bool codeSent,
    @Default(false) bool loading,
    @Default(false) bool agreeTerms,
    @Default(false) bool agreePrivacy,
    @Default(false) bool agreeMarketing,
  }) = _Signup;
}