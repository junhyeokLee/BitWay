// lib/constants/theme.dart
import 'package:flutter/material.dart';
import 'color.dart';

ThemeData bitwayTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primaryBlue,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.darkNavy,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.darkNavy),
    titleLarge: TextStyle(color: AppColors.darkNavy, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
);