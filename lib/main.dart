import 'package:flutter/material.dart';
import 'package:project_1/features/booking/presentation/view/booking_screen.dart';
import 'package:project_1/features/favorites/presentation/view/favorites_screen.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';
import 'package:project_1/features/auth/presentation/view/log_in_screen.dart';
import 'package:project_1/features/search/presentation/view/search_screen.dart';
import 'package:project_1/features/profile/presentation/view/profile_screen.dart';
import 'package:project_1/features/auth/presentation/view/sign_up_screen.dart';
import 'package:project_1/features/splash/presentation/view/splash_view.dart';

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) => const LogInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/bookings': (context) => const BookingScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: AppColors.primary,
      //     primary: AppColors.primary,
      //     secondary: AppColors.secondary,
      //     tertiary: AppColors.tertiary,
      //     surface: AppColors.neutral,
      //   ),
      //   textTheme: TextTheme(

      //     headlineLarge: AppFonts.headlineLarge,
      //     headlineMedium: AppFonts.headlineMedium,
      //     headlineSmall: AppFonts.headlineSmall,
      //     bodyLarge: AppFonts.bodyLarge,
      //     bodyMedium: AppFonts.bodyMedium,
      //     bodySmall: AppFonts.bodySmall,
      //     labelLarge: AppFonts.labelLarge,
      //     labelMedium: AppFonts.labelMedium,
      //     labelSmall: AppFonts.labelSmall,
      //   ),
      // ).copyWith(scaffoldBackgroundColor: Colors.white,textTheme
      //),
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
