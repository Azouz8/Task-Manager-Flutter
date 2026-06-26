import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xff121212),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xff8687E7),
    primaryContainer: Color(0xFFC1C1FF),
    secondary: Color(0xff272727),
    tertiary: Color(0xff4C4E72),
    surface: Color(0xff1E1E1E),
    onPrimary: Colors.white,
    inversePrimary: Color(0xFF1C1879),
    onSurface: Colors.white,
  ),

  cardColor: const Color(0xFF363636),
  checkboxTheme: CheckboxThemeData(
    shape: const CircleBorder(),
    side: WidgetStateBorderSide.resolveWith(
      (states) => const BorderSide(
        color: Color(0xff8687E7),
        width: 1.5,
      ),
    ),
    fillColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xff8687E7);
        }
        return Colors.transparent;
      },
    ),
    checkColor: const WidgetStatePropertyAll(Colors.white),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
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
    displayMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFAFAFAF),
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFC7C5D4),
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
    fillColor: const Color(0xff1D1D1D),

    hintStyle: GoogleFonts.inter(
      color: const Color(0xff8D8D8D),
      fontSize: 16,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xff3A3A3A),
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xff3A3A3A),
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
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
    enableFeedback: false,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    selectedIconTheme: IconThemeData(size: 24),
    unselectedIconTheme: IconThemeData(size: 20),
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
  ),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF2A2A2A),
  ),

  dividerColor: const Color(0xff3A3A3A),
);
