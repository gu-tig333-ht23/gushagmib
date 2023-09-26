import 'package:flutter/material.dart';
import 'package:template/controllers/theme_state.dart';
import 'package:provider/provider.dart';

class ToggleDarkThemeWidget extends StatelessWidget {
  ToggleDarkThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState themeController = context.watch<ThemeState>();
    // True as default
    return Switch(
      onChanged: (bool value) {
        themeController.setTheme = value;
      },
      value: themeController.isDarkModeActive,
    );
  }
}
