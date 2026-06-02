import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/theme/cubit/theme_cubit.dart';
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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
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
            themeMode: themeMode,

            theme: ThemeData.light(
              useMaterial3: true,
            ).copyWith(scaffoldBackgroundColor: Colors.white),
            darkTheme: ThemeData.dark(useMaterial3: true),
          );
        },
      ),
    );
  }
}
