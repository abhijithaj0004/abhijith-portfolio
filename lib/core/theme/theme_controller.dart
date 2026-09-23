import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _prefsKey = 'theme_mode_is_dark';

/// Holds the current theme mode and persists it to local storage so the
/// choice survives a page reload. Defaults to dark mode per the design spec.
class ThemeController extends ChangeNotifier {
  bool _isDark = true;
  bool _loaded = false;

  bool get isDark => _isDark;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDark = prefs.getBool(_prefsKey) ?? true;
    } catch (_) {
      // Storage unavailable (e.g. private browsing) — fall back to default.
      _isDark = true;
    }
    _loaded = true;
    notifyListeners();
  }

  bool get isLoaded => _loaded;

  Future<void> toggle() async {
    _isDark = !_isDark;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, _isDark);
    } catch (_) {
      // Ignore persistence failures — theme still applies for this session.
    }
  }
}
