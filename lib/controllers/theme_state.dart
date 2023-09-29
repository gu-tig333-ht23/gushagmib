import 'package:flutter/material.dart';
// Themes
import '../themes/themes.dart';

class ThemeState with ChangeNotifier {
  static final _controller = ThemeState._internal();
  // black theme as default
  bool _isDarkModeActive = true;

  ThemeData _theme = blackTheme();
  // Using singleton pattern to allow one controller only
  factory ThemeState() {
    return _controller;
  }

  set setTheme(bool value) {
    _isDarkModeActive = value;
    if (value) {
      _theme = blackTheme();
    } else {
      _theme = lightTheme();
    }

    notifyListeners();
  }

  ThemeData get theme => _theme;
  bool get isDarkModeActive => _isDarkModeActive;

  ThemeState._internal();
}
