import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'text_theme.dart';
import 'button_theme.dart';
import 'input_theme.dart';
import 'card_theme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,
    textTheme: AppTextTheme.light,
    elevatedButtonTheme: AppButtonTheme.elevated(AppColorScheme.light),
    inputDecorationTheme: AppInputTheme.light,
    cardTheme: AppCardTheme.light,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.dark,
    textTheme: AppTextTheme.dark,
    elevatedButtonTheme: AppButtonTheme.elevated(AppColorScheme.dark),
    inputDecorationTheme: AppInputTheme.dark,
    cardTheme: AppCardTheme.dark,
  );
}
