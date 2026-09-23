import 'package:flutter/material.dart';

/// Centralized color tokens. Never hardcode colors in widgets — reference
/// these instead so the whole app can be re-themed from one place.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF5B8DEF);
  static const Color primaryLight = Color(0xFF8FB3FF);
  static const Color accent = Color(0xFF3DDC97);

  // Dark theme
  static const Color darkBackground = Color(0xFF0B0D12);
  static const Color darkSurface = Color(0xFF12151C);
  static const Color darkSurfaceElevated = Color(0xFF171B24);
  static const Color darkBorder = Color(0xFF262B36);
  static const Color darkTextPrimary = Color(0xFFF4F5F7);
  static const Color darkTextSecondary = Color(0xFFA6ACBA);
  static const Color darkTextMuted = Color(0xFF6B7280);

  // Light theme
  static const Color lightBackground = Color(0xFFFAFAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF3F4F7);
  static const Color lightBorder = Color(0xFFE3E5EA);
  static const Color lightTextPrimary = Color(0xFF14161C);
  static const Color lightTextSecondary = Color(0xFF4B5163);
  static const Color lightTextMuted = Color(0xFF8B8F9C);

  // Status
  static const Color success = Color(0xFF3DDC97);
  static const Color error = Color(0xFFEF5D5D);

  static const List<Color> heroGradientDark = [
    Color(0xFF161A24),
    Color(0xFF0B0D12),
  ];

  static const List<Color> heroGradientLight = [
    Color(0xFFEFF3FF),
    Color(0xFFFAFAFB),
  ];
}
