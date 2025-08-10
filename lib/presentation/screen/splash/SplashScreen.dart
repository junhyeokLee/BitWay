import 'dart:convert';

import 'package:bitway/presentation/screen/main/home_screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/AuthStorage.dart';
import '../../provider/auth/UserProvider.dart';
import '../intro/IntroPageViewScreen.dart';
import '../login/LoginScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main/PremiumListScreen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), checkAuth);
  }

  void checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final firstRun = prefs.getBool('isFirstRun') ?? true;

    if (firstRun) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => IntroPageViewScreen()));
      return;
    }

    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final userJsonStr = prefs.getString('userInfo');
      if (userJsonStr != null) {
        final userJson = jsonDecode(userJsonStr);
        ref.read(userProvider.notifier).setUserFromJson(userJson);
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen2()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PremiumListScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
