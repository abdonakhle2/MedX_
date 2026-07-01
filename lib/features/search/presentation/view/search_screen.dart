import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/search/presentation/view/widgets/search_body.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final int _navIndex = 2;

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
        ),
        body: const SearchBody(),
      ),
    );
  }
}
