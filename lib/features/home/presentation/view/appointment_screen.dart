import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/appointment_body.dart';
import 'package:project_1/models/doctor.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor myDoctor;

  const AppointmentScreen({super.key, required this.myDoctor});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int stepIndex = 1;

  final int _navIndex = 0;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/favorites', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  // الشهر الذي يتصفحه المستخدم حالياً

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),

      body: const AppointmentBody(),
    );
  }
}
