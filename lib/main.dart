import 'package:bitway/screen/home_screen.dart';
import 'package:bitway/screen/home_screen2.dart';
import 'package:bitway/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // Ensure the screen size is configured
        ScreenUtil.ensureScreenSize();
        return MaterialApp(
          theme: bitwayTheme,
          home: const HomeScreen2(),
        );
      }
    );
  }
}
