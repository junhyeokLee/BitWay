import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/auth/res/User.dart';
import '../../viewmodel/auth/UserViewmodel.dart';

final userProvider = StateNotifierProvider<UserViewModel, User?>((ref) {
  return UserViewModel();
});
