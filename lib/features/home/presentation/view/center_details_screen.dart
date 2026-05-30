import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/center_details_body.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class CenterDetailsScreen extends StatefulWidget {
  const CenterDetailsScreen({super.key});

  @override
  State<CenterDetailsScreen> createState() => _CenterDetailsScreenState();
}

class _CenterDetailsScreenState extends State<CenterDetailsScreen> {
  final int _navIndex = 0;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/favorites', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      body: const SafeArea(child: CenterDetailsBody()),
    );
  }
}
