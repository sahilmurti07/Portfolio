import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF7C4DFF); // Purple
  static const Color secondaryColor = Color(0xFF00E5FF); // Cyan
  static const Color backgroundColor = Color(0xFF121212); // Dark background
  static const Color surfaceColor = Color(0xFF1E1E1E); // Cards/Containers
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      surface: surfaceColor,
    ),

    // 🔹 Global Typography with Open Sans Font
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      displayLarge: GoogleFonts.openSans(
        fontSize: 46,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineLarge: GoogleFonts.openSans(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.openSans(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
    ),

    cardTheme: CardThemeData(
      color: surfaceColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.all(12),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.openSans(color: Colors.grey),
    ),
  );
}
