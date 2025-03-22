import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFE84730),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'GE SS Two', // Set GE SS Two as the default font family for the app
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'GE SS Two',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6C3428),
        ),
        displayMedium: TextStyle(
          fontFamily: 'GE SS Two',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6C3428),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'GE SS Two',
          fontSize: 16,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'GE SS Two',
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xFFE84730),
        secondary: const Color(0xFF6C3428),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE84730),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'GE SS Two',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          fontFamily: 'GE SS Two',
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}