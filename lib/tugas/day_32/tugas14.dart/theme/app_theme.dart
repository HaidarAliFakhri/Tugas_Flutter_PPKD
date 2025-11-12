import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.orangeAccent;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true, // aktifkan Material 3
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    cardTheme: const CardThemeData(
      // ✅ gunakan CardThemeData, bukan CardTheme
      color: Colors.white,
      elevation: 3,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}
