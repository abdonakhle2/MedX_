import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/features/auth/presentation/view/log_in_screen.dart';
import 'package:project_1/features/auth/presentation/view/sign_up_screen.dart';
import 'package:project_1/features/booking/presentation/view/booking_screen.dart';
import 'package:project_1/features/favorites/presentation/view/favorites_screen.dart';
import 'package:project_1/features/home/presentation/view/appointment_screen.dart';
import 'package:project_1/features/home/presentation/view/center_details_screen.dart';
import 'package:project_1/features/notifications/presentation/view/notifications_screen.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';
import 'package:project_1/features/profile/presentation/view/profile_screen.dart';
import 'package:project_1/features/search/presentation/view/search_screen.dart';
import 'package:project_1/features/splash/presentation/view/splash_view.dart';
import 'package:project_1/models/doctor.dart';

abstract class AppRouter {
  static const String kSplashScreen = '/SplashView';
  static const String kSignUpScreen = '/SignUpScreen';
  static const String kLogInScreen = '/LogInScreen';
  static const String kHomeScreen = '/HomeScreen';
  static const String kCenterDetailsScreen = '/CenterDetailsScreen';
  static const String kAppointmentScreen = '/AppointmentScreen';
  static const String kBookingScreen = '/BookingScreen';
  static const String kFavoritesScreen = '/FavoritesScreen';
  static const String kProfileScreen = '/ProfileScreen';
  static const String kEditProfileScreen = '/EditProfileScreen';
  static const String kSearchScreen = '/SearchScreen';
  static const String kNotificationsScreen = '/NotificationsScreen';
  static late final GoRouter router;
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static void setupRouter(bool isLoggedIn) {
    router = GoRouter(
      initialLocation: isLoggedIn ? kHomeScreen : kSplashScreen,
      routes: [
        GoRoute(
          path: kSplashScreen,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: kSignUpScreen,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: kLogInScreen,
          builder: (context, state) => const LogInScreen(),
        ),
        GoRoute(
          path: kHomeScreen,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: kCenterDetailsScreen,
          builder: (context, state) =>
              CenterDetailsScreen(clinic: state.extra as ClinicModel),
        ),
        GoRoute(
          path: kAppointmentScreen,
          builder: (context, state) =>
              AppointmentScreen(myDoctor: state.extra as Doctor),
        ),
        GoRoute(
          path: kBookingScreen,
          builder: (context, state) => const BookingScreen(),
        ),
        GoRoute(
          path: kFavoritesScreen,
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: kProfileScreen,
          builder: (context, state) => const ProfileScreen(),
        ),
        // GoRoute(
        //   path: kEditProfileScreen,
        //   builder: (context, state) =>
        //       EditProfileScreen(user: state.extra as User),
        // ),
        GoRoute(
          path: kSearchScreen,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: kNotificationsScreen,
          builder: (context, state) => const NotificationsScreen(),
        ),
      ],
    );
  }
}
