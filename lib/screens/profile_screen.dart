import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _navIndex = 3;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.greyLight,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      child: Icon(
                        Icons.person,
                        size: 42,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Ahmed Ali', style: AppFonts.headlineLarge),
                    const SizedBox(height: 6),
                    Text(
                      'ahmed.ali@example.com',
                      style: AppFonts.bodyMedium.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildProfileItem('My Appointments', Icons.calendar_month),
              _buildProfileItem('My Favorites', Icons.favorite_border),
              _buildProfileItem('Settings', Icons.settings_outlined),
              _buildProfileItem('Logout', Icons.logout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: AppFonts.bodyLarge)),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
