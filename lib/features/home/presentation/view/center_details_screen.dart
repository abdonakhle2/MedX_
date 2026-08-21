import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/center_details_body.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';

import 'package:project_1/models/clinic.dart';

class CenterDetailsScreen extends StatefulWidget {
  final ClinicModel clinic;
  const CenterDetailsScreen({super.key, required this.clinic});

  @override
  State<CenterDetailsScreen> createState() => _CenterDetailsScreenState();
}

class _CenterDetailsScreenState extends State<CenterDetailsScreen> {
  final int _navIndex = 0;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = [
      AppRouter.kHomeScreen,
      AppRouter.kFavoritesScreen,
      AppRouter.kSearchScreen,
      AppRouter.kBookingScreen,
      AppRouter.kProfileScreen,
    ];
    // Navigator.pushReplacementNamed(context, routes[index]);
    GoRouter.of(context).pushReplacement(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      body: CenterDetailsBody(clinic: widget.clinic),
    );
  }
}
