import 'package:flutter/material.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_body.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _navIndex = 4;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/favorites', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
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
        body: const ProfileBody(),
      ),
    );
  }
}
