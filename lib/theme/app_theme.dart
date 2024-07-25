import 'package:flutter/material.dart';

final class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    useMaterial3: true,
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.blueAccent),
      ),
    ),
    primaryTextTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.blueAccent),
    ),
    appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true),
    // Diğer light theme özelliklerini buraya ekleyin
  );
  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      primaryTextTheme:
          const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      brightness: Brightness.dark,
      primaryColorDark: Colors.black,
      indicatorColor: Colors.white,
      canvasColor: Colors.black,
      appBarTheme: const AppBarTheme(centerTitle: true));
  // Diğer dark theme özelliklerini buraya ekleyi;
}
