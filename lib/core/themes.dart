import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class AppTheme {
  static ThemeData lighttheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E88E5),
      onPrimary: Colors.white,
      secondary: Color(0xFF43A047),
      onSecondary: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Color(0xFF1E1E1E),
      background: Color(0xFFF5F5F5),
      onBackground: Color(0xFF1E1E1E),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.roboto(color: Colors.black),
      bodyMedium: GoogleFonts.roboto(color: Colors.black),
      bodyLarge: GoogleFonts.roboto(color: Colors.black),
      labelSmall: GoogleFonts.roboto(color: Colors.black),
      labelMedium: GoogleFonts.roboto(color: Colors.black),
      labelLarge: GoogleFonts.roboto(color: Colors.black),
      titleSmall: GoogleFonts.pattaya(color: Colors.black),
      titleMedium: GoogleFonts.roboto(color: Colors.black),
      titleLarge: GoogleFonts.pattaya(color: Colors.black),
      headlineSmall: GoogleFonts.aBeeZee(color: Colors.black),
      headlineMedium: GoogleFonts.aBeeZee(color: Colors.black),
      headlineLarge: GoogleFonts.aBeeZee(color: Colors.black),
      displaySmall: GoogleFonts.abrilFatface(color: Colors.black),
      displayMedium: GoogleFonts.pattaya(color: Colors.black),
      displayLarge: GoogleFonts.pattaya(color: Colors.black),
    ),
  );

  static ThemeData darktheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.teal.shade400,
      onPrimary: Colors.white,
      secondary: Colors.orangeAccent,
      onSecondary: Colors.black,
      tertiary: const Color.fromARGB(179, 158, 69, 49),
      onTertiary: Colors.black,
      surface: Colors.grey.shade900,
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.roboto(color: Colors.white),
      bodyMedium: GoogleFonts.roboto(color: Colors.white),
      bodyLarge: GoogleFonts.roboto(color: Colors.white),
      labelSmall: GoogleFonts.roboto(color: Colors.white),
      labelMedium: GoogleFonts.roboto(color: Colors.white),
      labelLarge: GoogleFonts.roboto(color: Colors.white),
      titleSmall: GoogleFonts.pattaya(color: Colors.white),
      titleMedium: GoogleFonts.roboto(color: Colors.white),
      titleLarge: GoogleFonts.pattaya(color: Colors.white),
      headlineSmall: GoogleFonts.aBeeZee(color: Colors.white),
      headlineMedium: GoogleFonts.aBeeZee(color: Colors.white),
      headlineLarge: GoogleFonts.aBeeZee(color: Colors.white),
      displaySmall: GoogleFonts.abrilFatface(color: Colors.white),
      displayMedium: GoogleFonts.pattaya(color: Colors.white),
      displayLarge: GoogleFonts.pattaya(color: Colors.white),
    ),
  );
}
