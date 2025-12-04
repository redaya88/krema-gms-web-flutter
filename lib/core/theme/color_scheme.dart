import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppColorScheme {
  static ColorScheme get light => ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.gray800,
        onPrimary: Colors.white,
        secondary: AppColors.gray600,
        onSecondary: Colors.white,
        background: AppColors.lightBackground,
        onBackground: AppColors.lightText,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightText,
        error: Colors.redAccent,
        onError: Colors.white,
        outline: Colors.grey.shade400,
      );

  static ColorScheme get dark => ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.gray700,
        onPrimary: Colors.white,
        secondary: AppColors.gray600,
        onSecondary: Colors.white,
        background: AppColors.darkBackground,
        onBackground: AppColors.darkText,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
        error: Colors.redAccent,
        onError: Colors.white,
        outline: AppColors.border,
      );
}
