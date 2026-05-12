import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/models/doctor.dart';

import 'package:project_1/widgets/bottom_nav_bar.dart';
import 'package:project_1/widgets/doctor_card.dart';

class DepartmentScreen extends StatefulWidget {
  final String? category;
  const DepartmentScreen({super.key, this.category});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final int _navIndex = 0;

  Doctor myDoctor = Doctor(
    id: 1,
    name_en: "Dr. Julian Vane",
    name_ar: "د. جوليان فاين",
    specialization: "Cardiology",
    birthdate: "1980-05-15",
    id_passport: 12345678,
    // هنا نقوم بإنشاء ويدجت Image وتمريره
    photo: Image.asset('assets/images/doctor1.png', fit: BoxFit.cover),
    hourly_rate: 150.0,
    work_hours: "9 AM - 5 PM",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) {
          if (index == _navIndex) return;

          final routes = ['/home', '/search', '/bookings', '/profile'];
          Navigator.pushReplacementNamed(context, routes[index]);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'MedX',
              style: AppFonts.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.medical_services_rounded,
                  color: AppColors.primary,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  "DEPARTMENT",
                  style: AppFonts.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          GridView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return buildDoctorCard(myDoctor);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
