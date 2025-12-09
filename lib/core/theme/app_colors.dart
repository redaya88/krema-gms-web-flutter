import 'package:flutter/material.dart';

class AppColors {
  // LIGHT MODE COLORS
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Colors.white;
  static const Color lightText = Colors.black87;
  static const Color lightSecondaryText = Colors.black54;

  // DARK MODE COLORS
  static const Color darkBackground = Color(0xFF0F0F0F);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkText =
      Color.fromARGB(222, 255, 255, 255); // ~87% opacity
  static const Color darkSecondaryText =
      Color.fromARGB(153, 255, 255, 255); // ~60%

  // GRAYS (shared)
  static const Color gray800 = Color(0xFF1A1A1A);
  static const Color gray700 = Color(0xFF2A2A2A);
  static const Color gray600 = Color(0xFF3A3A3A);
  static const Color gray300 = Color(0xFFCFCFCF);

  // ACCENTS
  static const Color accent = Color(0xFF2E2E2E);
  static const Color accentHover = Color(0xFF3A3A3A);

  // BORDERS
  static const Color border = Color(0xFF3D3D3D);

  // GRADIENT
  static const LinearGradient sliderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E1E1E),
      Color(0xFF0E0E0E),
    ],
  );
}
