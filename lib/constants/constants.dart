import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0E7490);
  static const Color secondary = Color(0xFF64748B);
  static const Color tertiary = Color(0xFF2DD4BF);
  static const Color neutral = Color(0xFFF8FAFC);

  // Additional Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFF1F3F6);
  static const Color greyMedium = Color(0xFF64748B);
  static const Color error = Colors.red;
  static const Color success = Colors.green;
}

class AppFonts {
  // Font families

  // Headline styles
  static TextStyle headlineExtraLarge = TextStyle(
    fontFamily: GoogleFonts.manrope().fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineLarge = TextStyle(
    fontFamily: GoogleFonts.manrope().fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: GoogleFonts.manrope().fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: GoogleFonts.manrope().fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Body styles
  static TextStyle bodyLarge = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Label styles
  static TextStyle labelLarge = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
