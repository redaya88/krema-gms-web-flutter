import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppInputTheme {
  static InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: const TextStyle(color: AppColors.gray600),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.gray600, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.gray800, width: 1.5),
    ),
  );

  static InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.gray800,
    labelStyle: const TextStyle(color: AppColors.darkSecondaryText),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.border, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.white, width: 1.5),
    ),
  );
}
