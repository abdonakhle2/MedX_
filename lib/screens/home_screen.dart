import 'package:flutter/material.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';
import 'package:project_1/widgets/card_clinic.dart';
import 'package:project_1/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  int currentIndex = 0;

  void _onNavTap(int index) {
    if (index == currentIndex) return;

    final routes = ['/home', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(),
      backgroundColor: AppColors.greyLight,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTap,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                buildHeaderPage(),
                SizedBox(height: 24),
                buildBodyPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildBodyPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Medical Centers', style: AppFonts.headlineLarge),

          Text(
            'Facities available ',
            style: AppFonts.bodySmall.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return CardClinic();
            },
          ),
          const SizedBox(height: 30), // مسافة قبل الإحصائيات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2, // عنصرين في كل سطر
              childAspectRatio: 2.5, // لضبط ارتفاع العناصر
              children: [
                _buildStatItem('500+', 'SPECIALISTS'),
                _buildStatItem('15', 'DISTRICTS'),
                _buildStatItem('24/7', 'SUPPORT'),
                _buildStatItem('4.8', 'AVG RATING'),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Container buildHeaderPage() {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello , ${widget.userName}',
              style: AppFonts.headlineLarge.copyWith(color: Colors.white),
            ),
            SizedBox(height: 12),
            Text(
              'Find the specialist care you deserve ...Explore our curated network of premier medical centers .',
              style: AppFonts.bodyMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'MedX',
        style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.primary),
      ),
      centerTitle: true,
    );
  }
}

Widget _buildStatItem(String value, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        value,
        style: AppFonts.headlineSmall.copyWith(color: AppColors.primary),
      ),
      Text(
        label,
        style: AppFonts.labelSmall.copyWith(
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
      ),
    ],
  );
}
