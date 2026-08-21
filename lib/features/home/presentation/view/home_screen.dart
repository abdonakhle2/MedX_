import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // أضف هذا الاستيراد
import 'package:go_router/go_router.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart'; // أضف هذا الاستيراد
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/home_body.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';
import 'package:project_1/features/notifications/presentation/manager/cubit/notifications_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserAppointmentsCubit>().fetchUserAppointments();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchClinics();
      context.read<FavoritesCubit>().loadFavorites();
      context.read<ProfileCubit>().loadProfile();
      context.read<UserAppointmentsCubit>().fetchUserAppointments();
      context.read<NotificationsCubit>().fetchNotifications();
    });
  }

  void _onNavTap(int index) {
    if (index == currentIndex) return;

    final routes = [
      AppRouter.kHomeScreen,
      AppRouter.kFavoritesScreen,
      AppRouter.kSearchScreen,
      AppRouter.kBookingScreen,
      AppRouter.kProfileScreen,
    ];
    GoRouter.of(context).pushReplacement(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: _onNavTap,
        ),
        extendBody: true,
        body: const HomeBody(),
      ),
    );
  }
}
