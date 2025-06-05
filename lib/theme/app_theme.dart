import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    // Color palette for futuristic light theme
    const background = Color(0xFFF5F5F5);         // Soft white background
    const surface = Color(0xFFFFFFFF);            // Pure white surface for cards/app bars
    const accentGold = Color(0xFFFFC107);         // Elegant gold for highlights
    const darkText = Color(0xFF1A1A1A);           // Near-black text for contrast
    const grayText = Color(0xFF555555);           // Medium gray for secondary content

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,

      colorScheme: const ColorScheme.light(
        primary: accentGold,
        secondary: darkText,
        surface: surface,
        background: background,
      ),

      // Global font styling with modern, futuristic feel
      textTheme: GoogleFonts.titilliumWebTextTheme().copyWith(
        headlineSmall: const TextStyle(
          color: darkText,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: const TextStyle(
          color: darkText,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: const TextStyle(
          color: grayText,
        ),
        labelLarge: const TextStyle(
          color: darkText,
        ),
      ),

      // AppBar with light background and dark icons
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: darkText,
        centerTitle: true,
        elevation: 2,
      ),

      // Buttons with gold background and dark text
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentGold,
          foregroundColor: darkText,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: GoogleFonts.titilliumWeb(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Chips with clean gold-gray-white tones
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFE0E0E0),
        selectedColor: accentGold,
        labelStyle: const TextStyle(color: darkText),
        secondaryLabelStyle: const TextStyle(color: grayText),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        brightness: Brightness.light,
        disabledColor: Colors.grey.shade300,
        secondarySelectedColor: accentGold.withOpacity(0.8),
      ),

      dividerColor: Colors.grey.shade300,

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
