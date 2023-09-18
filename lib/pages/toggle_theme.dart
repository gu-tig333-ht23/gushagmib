import 'package:flutter/material.dart';
import 'package:template/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class ToggleDarkTheme extends StatelessWidget {
  ToggleDarkTheme({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = context.watch<ThemeController>();
    // True as default
    return Switch(
      onChanged: (bool value) {
        themeController.setTheme = value;
      },
      value: themeController.isDarkModeActive,
    );
  }
}
