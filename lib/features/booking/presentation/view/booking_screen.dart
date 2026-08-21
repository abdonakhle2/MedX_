import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/booking/data/booking_repo_imp.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart';
import 'package:project_1/features/booking/presentation/view/widgets/booking_body.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  final int _navIndex = 3;

  void _onNavTap(BuildContext context, int index) {
    if (index == _navIndex) return;

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
      child: BlocProvider(
        create: (context) =>
            UserAppointmentsCubit(BookingRepoImpl(Dio()))
              ..fetchUserAppointments(),
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNavBar(
            currentIndex: _navIndex,
            onTap: (index) => _onNavTap(context, index),
          ),
          body: const BookingBody(),
        ),
      ),
    );
  }
}
