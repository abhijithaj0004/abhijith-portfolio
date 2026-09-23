import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Font-size / weight scale. Uses the platform default font family
/// (no external font fetch, so it stays reliable on Flutter Web).
class AppTypography {
  AppTypography._();

  // Flutter Web falls back to the platform's default sans-serif stack when
  // fontFamily is left null, which keeps this reliable without bundling or
  // fetching a webfont. fontFamilyFallback nudges it toward common system UI
  // fonts across platforms.
  static const String? fontFamily = null;
  static const List<String> fontFamilyFallback = [
    'Segoe UI',
    'Roboto',
    'Helvetica Neue',
    'Arial',
    'sans-serif',
  ];

  static TextStyle display(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 56,
        fontWeight: FontWeight.w700,
        height: 1.08,
        letterSpacing: -1.2,
        color: color,
      );

  static TextStyle h1(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.8,
        color: color,
      );

  static TextStyle h2(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
        color: color,
      );

  static TextStyle h3(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: color,
      );

  static TextStyle bodyLarge(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      );

  static TextStyle body(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      );

  static TextStyle label(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
        color: color,
      );

  static TextStyle button(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color,
      );
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 80;
}

class AppRadius {
  AppRadius._();
  static const double sm = 8;
  static const double md = 14;
  static const double lg = 20;
  static const double pill = 999;
}

class AppShadows {
  AppShadows._();

  static List<BoxShadow> soft(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.35)
              : Colors.black.withOpacity(0.06),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withOpacity(0.35),
          blurRadius: 30,
          spreadRadius: -6,
        ),
      ];
}
