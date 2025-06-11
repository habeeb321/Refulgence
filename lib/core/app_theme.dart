import 'package:flutter/material.dart';
import 'package:refulgence/core/constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Constants.themeBlue,
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 1, 91, 164),
    ),
    scaffoldBackgroundColor: const Color(0xffEDE8F7),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Constants.themeBlue,
      unselectedItemColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 1, 91, 164),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
  );

  static ThemeData get theme {
    return lightTheme;
  }
}
