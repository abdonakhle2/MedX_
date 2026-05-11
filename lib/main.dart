import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1/screens/booking_screen.dart';
import 'package:project_1/screens/home_screen.dart';
import 'package:project_1/screens/log_in_screen.dart';
import 'package:project_1/screens/search_screen.dart';
import 'package:project_1/screens/profile_screen.dart';
import 'package:project_1/screens/sign_up_screen.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/screens/splash_view.dart';

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
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/splash':
            page = const SplashView();
            break;
          case '/login':
            page = const LogInScreen();
            break;
          case '/signup':
            page = const SignUpScreen();
            break;
          case '/home':
            page = const HomeScreen();
            break;
          case '/search':
            page = const SearchScreen();
            break;
          case '/bookings':
            page = const BookingScreen();
            break;
          case '/profile':
            page = const ProfileScreen();
            break;
          default:
            return null;
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 200),
        );
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
