import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  bool _isDarkMode;

  ThemeService({required Brightness brightness})
      : _isDarkMode = brightness == Brightness.dark;

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
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
