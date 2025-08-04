import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth/res/User.dart';

class UserViewModel extends StateNotifier<User?> {
  UserViewModel() : super(null);

  void setUserFromJson(Map<String, dynamic> json) {
    state = User.fromJson(json);
  }

  void clearUser() {
    state = null;
  }
}