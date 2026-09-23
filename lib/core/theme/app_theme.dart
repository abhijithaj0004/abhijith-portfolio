import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        textPrimary: AppColors.darkTextPrimary,
        textSecondary: AppColors.darkTextSecondary,
        border: AppColors.darkBorder,
      );

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        textPrimary: AppColors.lightTextPrimary,
        textSecondary: AppColors.lightTextSecondary,
        border: AppColors.lightBorder,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color textPrimary,
    required Color textSecondary,
    required Color border,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      primaryColor: AppColors.primary,
      fontFamily: AppTypography.fontFamily,
      fontFamilyFallback: AppTypography.fontFamilyFallback,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.black,
        error: AppColors.error,
        onError: Colors.white,
        background: background,
        onBackground: textPrimary,
        surface: surface,
        onSurface: textPrimary,
      ),
      dividerColor: border,
      textTheme: TextTheme(
        displayLarge: AppTypography.display(textPrimary),
        headlineLarge: AppTypography.h1(textPrimary),
        headlineMedium: AppTypography.h2(textPrimary),
        headlineSmall: AppTypography.h3(textPrimary),
        bodyLarge: AppTypography.bodyLarge(textSecondary),
        bodyMedium: AppTypography.body(textSecondary),
        labelLarge: AppTypography.label(textSecondary),
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: AppColors.primary.withOpacity(0.2),
      visualDensity: VisualDensity.standard,
    );
  }
}

/// Convenience accessors so widgets can read "the current text color for
/// this theme" without repeating brightness checks everywhere.
extension ThemeColors on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDarkMode ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  Color get textSecondary =>
      isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  Color get textMuted =>
      isDarkMode ? AppColors.darkTextMuted : AppColors.lightTextMuted;

  Color get surfaceColor =>
      isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;

  Color get surfaceElevated => isDarkMode
      ? AppColors.darkSurfaceElevated
      : AppColors.lightSurfaceElevated;

  Color get borderColor =>
      isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;

  List<Color> get heroGradient =>
      isDarkMode ? AppColors.heroGradientDark : AppColors.heroGradientLight;
}
