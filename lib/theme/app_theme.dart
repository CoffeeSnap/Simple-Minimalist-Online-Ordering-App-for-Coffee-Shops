import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const Color lightBrown = Color(0xFFD4A574);
  static const Color darkBrown = Color(0xFF8B6F47);
  static const Color coffeeGreen = Color(0xFF8BA888);
  static const Color paleYellow = Color(0xFFFFF8DC);
  static const Color cream = Color(0xFFFFFAF0);
  static const Color darkGreen = Color(0xFF5F7161);

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightBrown,
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.light(
      primary: lightBrown,
      secondary: coffeeGreen,
      surface: paleYellow,
      background: cream,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBrown,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: coffeeGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: paleYellow,
      selectedColor: coffeeGreen,
      labelStyle: const TextStyle(fontSize: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
    ),
  );
}
