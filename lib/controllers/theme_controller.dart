import 'package:flutter/material.dart';
// Themes
import '../themes/themes.dart';

class ThemeController with ChangeNotifier {
  static final _controller = ThemeController._internal();
  // Light theme as default
  ThemeData _theme = blackTheme();
  // Using singleton pattern to allow one controller only
  factory ThemeController() {
    return _controller;
  }

  set setTheme(bool value) {
    if (value) {
      _theme = blackTheme();
    } else {
      _theme = lightTheme();
    }

    notifyListeners();
  }

  ThemeData get theme => _theme;

  ThemeController._internal();
}
