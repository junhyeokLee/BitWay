import 'package:bitway/presentation/screen/splash/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BitWayApp extends StatelessWidget {
  const BitWayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitWay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}