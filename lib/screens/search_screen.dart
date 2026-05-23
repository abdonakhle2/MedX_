import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/models/doctor.dart';
import 'package:project_1/screens/department_screen.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';
import 'package:project_1/widgets/card_clinic.dart';
import 'package:project_1/widgets/doctor_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final int _navIndex = 1;
  bool isCenter = true;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/search', '/bookings', '/profile'];
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Search',
                    style: AppFonts.headlineMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppShadows.softShadow,
                      ),
                      child: TextField(
                        style: AppFonts.bodyMedium,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.search_rounded,
                              color: AppColors.primary,
                            ),
                          ),
                          hintText: 'Search for doctors or centers',
                          hintStyle: AppFonts.bodyMedium.copyWith(
                            color: AppColors.secondary.withOpacity(0.5),
                          ),
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    buildBodyButton(),
                    const SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryLight.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        'Search Results',
                        style: AppFonts.headlineMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(
                              milliseconds: 300 + (index * 100),
                            ),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 15 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: isCenter
                                ? CardClinic()
                                : buildDoctorCard(
                                    Doctor(
                                      doc_id: '1',
                                      name_en: 'ali ahmad',
                                      name_ar: 'علي احمد',
                                      birthdate: '2/3/2000',
                                      id_passport: '12',
                                      photo: '',
                                      hourly_rate: 12,
                                      work_hours: '4',
                                      specialization: 'cardiology',
                                      appointments: [],
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildResultSearch(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadows.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Search Result ${index + 1}',
                  style: AppFonts.headlineSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cardiology · MedX Center',
                  style: AppFonts.bodySmall.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBodyButton() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.softShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isCenter = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isCenter ? AppGradients.primaryGradient : null,
                  color: isCenter ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isCenter ? AppShadows.elevatedShadow : [],
                ),
                child: Center(
                  child: Text(
                    'Center',
                    style: AppFonts.labelLarge.copyWith(
                      color: isCenter ? Colors.white : AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isCenter = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: !isCenter ? AppGradients.primaryGradient : null,
                  color: !isCenter ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: !isCenter ? AppShadows.elevatedShadow : [],
                ),
                child: Center(
                  child: Text(
                    'Doctor',
                    style: AppFonts.labelLarge.copyWith(
                      color: !isCenter ? Colors.white : AppColors.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
