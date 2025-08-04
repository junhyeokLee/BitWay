import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/auth/req/Signup.dart';
import '../../viewmodel/SignUpViewmodel.dart';

final signupNotifierProvider =
StateNotifierProvider<SignupViewModel, Signup>((ref) {
  return SignupViewModel();
});