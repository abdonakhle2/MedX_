import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/department_widgets/department_body.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class DepartmentScreen extends StatefulWidget {
  final String? category;
  const DepartmentScreen({super.key, this.category});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
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
      body: const DepartmentBody(),
    );
  }
}
