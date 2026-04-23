import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0E7490);
  static const Color primaryDark = Color(0xFF0A5B72);
  static const Color primaryLight = Color(0xFF22D3EE);
  static const Color secondary = Color(0xFF64748B);
  static const Color tertiary = Color(0xFF2DD4BF);
  static const Color neutral = Color(0xFFF8FAFC);

  // Additional Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFF1F3F6);
  static const Color greyMedium = Color(0xFF64748B);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);

  // Accent Colors
  static const Color amber = Color(0xFFF59E0B);
  static const Color cardBg = Color(0xFFFDFDFD);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0E7490), Color(0xFF0891B2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryDarkGradient = LinearGradient(
    colors: [Color(0xFF0A5B72), Color(0xFF0E7490)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF0E7490), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xFF0E7490), Color(0xFF22D3EE), Color(0xFF2DD4BF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppShadows {
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.06),
      spreadRadius: 0,
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: AppColors.primary.withOpacity(0.04),
      spreadRadius: 0,
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.15),
      spreadRadius: 0,
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.04),
      spreadRadius: 0,
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];
}

class AppFonts {
  // Font families
  // Headline styles
  static TextStyle headlineExtraLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Body styles
  static TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Label styles
  static TextStyle labelLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}
