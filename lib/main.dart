import 'package:flutter/material.dart';
import 'package:project_1/screens/booking_screen.dart';
import 'package:project_1/screens/log_in_screen.dart';
import 'package:project_1/constants/constants.dart';

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
          surface: AppColors.neutral,
        ),
        textTheme: TextTheme(
          headlineLarge: AppFonts.headlineLarge,
          headlineMedium: AppFonts.headlineMedium,
          headlineSmall: AppFonts.headlineSmall,
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
          labelLarge: AppFonts.labelLarge,
          labelMedium: AppFonts.labelMedium,
          labelSmall: AppFonts.labelSmall,
        ),
      ),
      home: const LogInScreen(),
    );
  }
}
