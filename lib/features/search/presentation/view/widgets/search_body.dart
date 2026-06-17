import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_app_bar.dart';
import 'package:project_1/models/doctor.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/core/widgets/doctor_card.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  bool isCenter = true;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSearchAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
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
                const SizedBox(height: 20),
                buildBodyButton(),
                const SizedBox(height: 24),

                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 12),
                //   decoration: BoxDecoration(
                //     // color: AppColors.primaryLight.withOpacity(0.15),
                //     borderRadius: BorderRadius.circular(20),
                //     border: Border.all(
                //       color: AppColors.primaryLight.withOpacity(0.3),
                //     ),
                //   ),
                //   child: Text(
                //     'Search Results',
                //     style: AppFonts.headlineMedium.copyWith(
                //       // color: AppColors.primary,
                //       fontWeight: FontWeight.w800,
                //       letterSpacing: -0.5,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 12),
                isCenter
                    ? ListView.builder(
                        shrinkWrap: true,

                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final dummyClinic = ClinicModel(
                            clinic_id: 'search_clinic_$index',
                            name_en: 'Search Clinic Center ${index + 1}',
                            name_ar: 'مركز عيادات البحث ${index + 1}',
                            description: 'A cornerstone of regional health, providing comprehensive emergency care, surgery, and advanced diagnostics.',
                            location: '${0.5 + index * 0.4} miles away',
                            work_hours: 8,
                            phone_number: '987654321',
                            logo: '',
                            lat: 0.0,
                            log: 0.0,
                            is_24h: false,
                            pictures: [],
                            Departments: [],
                          );

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
                                ? CardClinic(clinic: dummyClinic)
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
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder<double>(
                            key: ValueKey('doctor_$index'),
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
                            child: buildDoctorCard(
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
                              isGridView: true,
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ],
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
