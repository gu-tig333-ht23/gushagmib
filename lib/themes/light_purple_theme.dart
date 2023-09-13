import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  const textColor = Colors.black;
  // The textcolor for e
  const bodyTextColor = Colors.black;
  const iconColor = Colors.black;
  // The color for the elevatedButton icon and text color
  const elevatedButtonColor = iconColor;
  // appbar background
  const primaryColour = Color.fromARGB(255, 221, 172, 228);
  const primaryAccentColour = Color.fromARGB(255, 222, 180, 227);
  // Background color for the scaffold aka rest of the app
  const appBackGroundColor = Colors.white;
  String? font = GoogleFonts.roboto().fontFamily;

  return ThemeData(
    primaryColor: primaryColour,
    scaffoldBackgroundColor: appBackGroundColor,
    fontFamily: font,
    // Appbar theme
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: iconColor,
      ),
      actionsIconTheme: IconThemeData(
        size: 30,
      ),
      backgroundColor: primaryColour,
      titleTextStyle: TextStyle(
        fontSize: 25,
        color: textColor,
        fontFamily: font,
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: appBackGroundColor,
      titleTextStyle: TextStyle(
        color: bodyTextColor,
        fontSize: 18,
        fontFamily: font,
        // Set lineThrough etc to same color as bodyText...
        decorationColor: bodyTextColor,
        decorationThickness: 2.2,
      ),
      textColor: bodyTextColor,
      iconColor: iconColor,
    ),
    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(
        color: bodyTextColor,
        fontSize: 17,
        fontFamily: font,
      ),
      hintStyle: TextStyle(
        color: bodyTextColor,
        fontSize: 17,
        fontFamily: font,
      ),
      floatingLabelStyle: TextStyle(
        color: bodyTextColor,
        fontSize: 16,
        fontFamily: font,
      ),
      labelStyle: TextStyle(
        color: bodyTextColor,
        fontSize: 18,
        fontFamily: font,
      ),
      border: OutlineInputBorder(),
    ),
    iconTheme: IconThemeData(
      color: iconColor,
    ),
    // PopupMenuTheme
    popupMenuTheme: PopupMenuThemeData(
      surfaceTintColor: primaryAccentColour,
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(color: bodyTextColor, fontFamily: font, fontSize: 14),
      ),
      textStyle:
          TextStyle(color: bodyTextColor, fontFamily: font, fontSize: 16),
    ),

    // FloatingActionButtonTheme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColour,
      foregroundColor: iconColor,
    ),
    //elevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 16)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150.0),
          ),
        ),
        // Color four the background on button
        backgroundColor: MaterialStateProperty.all<Color>(primaryColour),
        // Icon color also sets the button text color
        foregroundColor: MaterialStateProperty.all<Color>(elevatedButtonColor),
      ),
    ),
    textTheme: TextTheme(
        titleMedium: TextStyle(
      fontSize: 18,
      color: bodyTextColor,
      fontFamily: font,
    )),
    useMaterial3: true,
  );
}
