import 'package:bitway/presentation/screen/main/home_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../provider/auth/AuthProvider.dart';
import '../../provider/auth/UserProvider.dart';
import '../signup/SignUpScreen.dart';

final loginLoadingProvider = StateProvider<bool>((ref) => false);

class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(loginLoadingProvider);

    Future<void> login() async {
      ref.read(loginLoadingProvider.notifier).state = true;
      // final repo = ref.read(authRepositoryProvider);

      // final userJson = await repo.login(
      //   emailController.text,
      //   passwordController.text,
      // );

      ref.read(loginLoadingProvider.notifier).state = false;

      // if (userJson != null) {
      //   print('userJson runtimeType: ${userJson.runtimeType}');
      //
      //   if (userJson is Map<String, dynamic>) {
      //     final prefs = await SharedPreferences.getInstance();
      //     await prefs.setString('userInfo', jsonEncode(userJson));
      //     await prefs.setBool('isLoggedIn', true);
      //
      //     ref.read(userProvider.notifier).setUserFromJson(Map<String, dynamic>.from(userJson as dynamic));
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen2()));
      //   } else {
      //     print('Unexpected userJson structure: $userJson');
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('로그인 실패: 잘못된 응답 구조')),
      //     );
      //   }
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('로그인 실패')),
      //   );
      // }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "로그인",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BitWay에 오신 걸 환영합니다 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "이메일",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "비밀번호",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 24),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("로그인", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignUpEmailScreen()),
              ),
              child: Text(
                "처음이신가요? 가입하기",
                style: TextStyle(color: Colors.white70, fontSize: 14, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}