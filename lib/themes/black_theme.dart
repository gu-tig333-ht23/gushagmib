import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData blackTheme() {
  const textColor = Colors.white;
  const bodyTextColor = Colors.white;
  const textMenuColor = Colors.white;
  // Icon color for application
  const iconColor = Colors.pinkAccent;
  // The color for the elevatedButton & floating action button
  // icon (and text color as they count as one)
  const elevatedIconColor = Colors.white;
  // Sets the buttonbackground
  const buttonBackGroundColor = iconColor;
  // Background color for the scaffold aka rest of the app
  const appBackGroundColor = Color.fromARGB(255, 28, 23, 32);
  // appbar background
  const primaryColour = Colors.black;
  const primaryAccentColour = Colors.blueGrey;

  const listTileColor = Colors.black;
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
    switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(buttonBackGroundColor)),
    listTileTheme: ListTileThemeData(
      tileColor: listTileColor,
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
      color: appBackGroundColor,
      shadowColor: primaryAccentColour,
      labelTextStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(color: textMenuColor, fontFamily: font, fontSize: 14),
      ),
      textStyle:
          TextStyle(color: textMenuColor, fontFamily: font, fontSize: 16),
    ),

    // FloatingActionButtonTheme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: buttonBackGroundColor,
      foregroundColor: elevatedIconColor,
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
        backgroundColor:
            MaterialStateProperty.all<Color>(buttonBackGroundColor),
        // Icon color also sets the button text color
        foregroundColor: MaterialStateProperty.all<Color>(elevatedIconColor),
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
