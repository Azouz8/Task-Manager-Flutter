import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xff121212),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xff8687E7),
    secondary: Color(0xff272727),
    tertiary: Color(0xff4C4E72),
    surface: Color(0xff1E1E1E),
    onPrimary: Colors.white,
    onSurface: Colors.white,
  ),

  cardColor: const Color(0xff1E1E1E),

  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: const Color(0xff121212),
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  textTheme: TextTheme(
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineMedium: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    titleLarge: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      color: Colors.white,
    ),

    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      color: const Color(0xffB3B3B3),
    ),

    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      color: const Color(0xff8D8D8D),
    ),

    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff8687E7),
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff1E1E1E),

    hintStyle: GoogleFonts.inter(
      color: const Color(0xff8D8D8D),
      fontSize: 16,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xff3A3A3A),
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xff3A3A3A),
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xff8687E7),
        width: 2,
      ),
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff1E1E1E),
    selectedItemColor: Color(0xff8687E7),
    unselectedItemColor: Color(0xffB3B3B3),
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    showSelectedLabels: false,
  ),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  dividerColor: const Color(0xff3A3A3A),
);
