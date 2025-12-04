import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCardTheme {
  static CardThemeData light = CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Colors.grey),
    ),
  );

  static CardThemeData dark = CardThemeData(
    color: AppColors.gray800,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.border),
    ),
  );
}
