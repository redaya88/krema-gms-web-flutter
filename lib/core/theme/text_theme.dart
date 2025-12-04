import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme light = const TextTheme(
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.lightText),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.lightText),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightText),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightSecondaryText),
  );

  static TextTheme dark = const TextTheme(
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkText),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.darkText),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkText),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkSecondaryText),
  );
}
