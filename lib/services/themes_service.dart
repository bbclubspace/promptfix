import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class ThemeService with ChangeNotifier {
  bool _isDarkMode;

  /// Başlangıçta tema modu cihazın varsayılan moduna göre ayarlanır
  factory ThemeService({bool? isDark}) {
    final brightness = isDark == null
        ? PlatformDispatcher.instance.platformBrightness
        : (isDark ? Brightness.dark : Brightness.light);
    return ThemeService._internal(brightness: brightness);
  }

  ThemeService._internal({required Brightness brightness})
      : _isDarkMode = brightness == Brightness.dark;

  // Factory: Kaydedilmiş tema modunu yükleyerek ThemeService oluşturur
  static Future<ThemeService> create() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode');
    final brightness = isDark == null
        ? PlatformDispatcher.instance.platformBrightness
        : (isDark ? Brightness.dark : Brightness.light);
    return ThemeService._internal(brightness: brightness);
  }

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveThemeMode();
    notifyListeners();
  }

  void saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode');
    if (isDark != null) {
      _isDarkMode = isDark;
      notifyListeners();
    }
  }

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
    );
  }
}
