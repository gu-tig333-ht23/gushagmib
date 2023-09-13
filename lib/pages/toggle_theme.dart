import 'package:flutter/material.dart';
import 'package:template/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class ToggleDarkTheme extends StatefulWidget {
  const ToggleDarkTheme({super.key});

  @override
  State<ToggleDarkTheme> createState() => _ToggleDarkThemeState();
}

class _ToggleDarkThemeState extends State<ToggleDarkTheme> {
  bool _dark = true;
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = context.watch<ThemeController>();
    return Switch(
      value: _dark,
      onChanged: (bool value) {
        setState(() {
          if (value) {
            _dark = value;
          } else {
            _dark = value;
          }
          themeController.setTheme = _dark;
        });
      },
    );
  }
}
