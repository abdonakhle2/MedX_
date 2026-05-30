import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/home_body.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  void _onNavTap(int index) {
    if (index == currentIndex) return;

    final routes = ['/home', '/favorites', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
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
        body: HomeBody(),
      ),
    );
  }
}
