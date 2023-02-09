import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConfigThemeData {
  static String fontFamily = 'Vazir';
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backGroundColor;
  final Color primaryColor;
  final Color appBarColor;
  final Brightness brightness;

  MyConfigThemeData.dark()
      : primaryTextColor = const Color.fromARGB(255, 255, 255, 255),
        secondaryTextColor = const Color.fromARGB(255, 170, 170, 170),
        backGroundColor = const Color.fromARGB(255, 24, 24, 24),
        primaryColor = const Color.fromARGB(255, 25, 39, 52),
        appBarColor = const Color.fromARGB(255, 33, 33, 33),
        brightness = Brightness.dark;

  MyConfigThemeData.light()
      : primaryTextColor = const Color.fromARGB(255, 0, 0, 0),
        secondaryTextColor = const Color.fromARGB(255, 85, 85, 85),
        backGroundColor = const Color.fromARGB(255, 230, 230, 230),
        primaryColor = const Color.fromARGB(255, 87, 155, 177),
        appBarColor = const Color.fromARGB(255, 222, 222, 222),
        brightness = Brightness.light;

  ThemeData themeData(String languageCode) {
    return ThemeData(
      primaryColor: primaryColor,
      brightness: brightness,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        filled: true,
      ),
      dividerTheme: DividerThemeData(
        space: 36,
        thickness: 2,
        indent: 15,
        endIndent: 15,
        color: appBarColor,
      ),
      scaffoldBackgroundColor: backGroundColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: appBarColor,
        foregroundColor: primaryTextColor,
      ),
      textTheme:
      languageCode == 'en' ? enPrimaryTextTheme() : faPrimaryTextTheme(),
    );
  }

  TextTheme enPrimaryTextTheme() {
    return GoogleFonts.latoTextTheme(
      TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: primaryTextColor,
          fontWeight: FontWeight.w900,
        ),
        bodySmall: TextStyle(
          fontSize: 15,
          color: secondaryTextColor,
        ),
      ),
    );
  }

  TextTheme faPrimaryTextTheme() {
    return TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: primaryTextColor,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w900,
        color: primaryTextColor,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: primaryTextColor,
        fontWeight: FontWeight.w900,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        color: secondaryTextColor,
        fontFamily: fontFamily,
      ),
    );
  }
}