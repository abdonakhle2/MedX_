import 'package:go_router/go_router.dart';
import 'package:project_1/features/auth/presentation/view/log_in_screen.dart';
import 'package:project_1/features/auth/presentation/view/sign_up_screen.dart';
import 'package:project_1/features/booking/presentation/view/booking_screen.dart';
import 'package:project_1/features/favorites/presentation/view/favorites_screen.dart';
import 'package:project_1/features/home/presentation/view/appointment_screen.dart';
import 'package:project_1/features/home/presentation/view/center_details_screen.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';
import 'package:project_1/features/profile/presentation/view/edit_profile_screen.dart';
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
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
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
        builder: (context, state) => const CenterDetailsScreen(),
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
      GoRoute(
        path: kEditProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: kSearchScreen,
        builder: (context, state) => const SearchScreen(),
      ),
    ],
  );
}
