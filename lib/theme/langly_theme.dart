import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanglyTheme {
  static const Color langlyPrimary = Color(0xFF2563EB);
  static const Color langlyAccent = Color(0xFF06B6D4);

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.nunito(
        fontSize: 32.0, fontWeight: FontWeight.w900, color: Colors.black),
    bodyLarge: GoogleFonts.nunito(
        fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.nunito(
        fontSize: 32.0, fontWeight: FontWeight.w900, color: Colors.white),
    bodyLarge: GoogleFonts.nunito(
        fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.white),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: langlyPrimary,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: langlyPrimary,
          foregroundColor: Colors.white,
          elevation: 0),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: langlyPrimary),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: langlyPrimary,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          elevation: 0
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: langlyPrimary,
          unselectedItemColor: Colors.white60),
      textTheme: darkTextTheme,
    );
  }
}