import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  const textColor = Colors.black;
  const bodyTextColor = Colors.black;
  const iconColor = Colors.black;
  const primaryColour = Color.fromARGB(255, 235, 197, 240);
  const bodyTextSize = 18.0;
  const appBarTextSize = 25.0;
  String? font = GoogleFonts.roboto().fontFamily;

  return ThemeData(
    inputDecorationTheme: _inputDecorationTheme(),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    popupMenuTheme: _popupMenuThemeData(textColor, font, bodyTextSize),
    appBarTheme:
        _appBarTheme(iconColor, primaryColour, appBarTextSize, textColor, font),
    floatingActionButtonTheme:
        _floatingActionButtonTheme(primaryColour, iconColor),
    elevatedButtonTheme: _elevatedButtonTheme(font, primaryColour),
    textTheme: _textTheme(textColor, font, bodyTextColor, bodyTextSize),
    useMaterial3: true,
  );
}

TextTheme _textTheme(
    Color textColor, String? font, Color bodyTextColor, double bodyTextSize) {
  return TextTheme(
    labelMedium: TextStyle(
      color: textColor,
      fontSize: 16,
      fontFamily: font,
    ),
    bodyMedium: TextStyle(
      color: bodyTextColor,
      fontSize: bodyTextSize,
      fontFamily: font,
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme(
    String? font, Color primaryColour) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        fontFamily: font,
        color: Colors.purple,
      )),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColour),
    ),
  );
}

FloatingActionButtonThemeData _floatingActionButtonTheme(
    Color primaryColour, Color iconColor) {
  return FloatingActionButtonThemeData(
    backgroundColor: primaryColour,
    foregroundColor: iconColor,
  );
}

AppBarTheme _appBarTheme(Color iconColor, Color primaryColour,
    double appBarTextSize, Color textColor, String? font) {
  return AppBarTheme(
    actionsIconTheme: IconThemeData(
      size: 30,
    ),
    backgroundColor: primaryColour,
    titleTextStyle: TextStyle(
      fontSize: appBarTextSize,
      color: textColor,
      fontFamily: font,
    ),
  );
}

PopupMenuThemeData _popupMenuThemeData(
    Color textColor, String? font, double bodyTextSize) {
  return PopupMenuThemeData(
    textStyle:
        TextStyle(color: textColor, fontFamily: font, fontSize: bodyTextSize),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(),
  );
}
