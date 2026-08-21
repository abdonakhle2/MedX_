import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_department_card.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/widgets/doctor_card.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/core/widgets/custom_error_widget.dart';
import 'package:shimmer/shimmer.dart';

class CustomCenterDetailsDepartmentList extends StatefulWidget {
  final ClinicModel clinic;
  const CustomCenterDetailsDepartmentList({super.key, required this.clinic});

  @override
  State<CustomCenterDetailsDepartmentList> createState() =>
      _CustomCenterDetailsDepartmentListState();
}

class _CustomCenterDetailsDepartmentListState
    extends State<CustomCenterDetailsDepartmentList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchClinicDepartments(widget.clinic.clinic_id);
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width < 600 ? 2 : 3;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) return;
        final cubit = context.read<HomeCubit>();
        final clinicDepartments =
            cubit.clinicDepartments[widget.clinic.clinic_id];
        if (clinicDepartments != null && clinicDepartments.isNotEmpty) {
          if (selectedIndex < clinicDepartments.length) {
            final currentDepartment = clinicDepartments[selectedIndex];
            if (currentDepartment.dep_id != null &&
                !cubit.departmentDoctors.containsKey(
                  currentDepartment.dep_id,
                )) {
              cubit.fetchDoctorsByDepartment(currentDepartment.dep_id!);
            }
          }
        }
      },
      builder: (context, state) {
        final clinicDepartments = context
            .read<HomeCubit>()
            .clinicDepartments[widget.clinic.clinic_id];

        if (clinicDepartments == null) {
          if (state is HomeFailure) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomErrorWidget(
                errorMessage: state.errorMessage,
                onRetry: () {
                  context.read<HomeCubit>().fetchClinicDepartments(
                    widget.clinic.clinic_id,
                  );
                },
              ),
            );
          }

          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
          final highlightColor = isDarkMode
              ? Colors.grey[700]!
              : Colors.grey[100]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 24,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxis,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (clinicDepartments.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(localeText.centerNoDepartments),
            ),
          );
        }

        // Ensure selected index is valid
        if (selectedIndex >= clinicDepartments.length) {
          selectedIndex = 0;
        }

        final currentDepartment = clinicDepartments[selectedIndex];
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(clinicDepartments.length, (index) {
                      final dep = clinicDepartments[index];
                      final location = isArabic
                          ? (dep.location_ar ?? '')
                          : (dep.location_en ?? '');
                      final desc =
                          isArabic && (dep.description_ar?.isNotEmpty ?? false)
                          ? dep.description_ar!
                          : (dep.description_en ?? '');

                      // Extract department name from description based on language
                      String extractedTitle = dep.category ?? 'Department';
                      if (isArabic && desc.startsWith('قسم')) {
                        final parts = desc.split(' ');
                        if (parts.length >= 2) {
                          extractedTitle = '${parts[0]} ${parts[1]}';
                        }
                      } else if (!isArabic && desc.contains(' Department')) {
                        extractedTitle = desc.substring(
                          0,
                          desc.indexOf(' Department') + 11,
                        );
                      }

                      return CustomDepartmentCard(
                        icon: _getDepartmentIcon(extractedTitle),
                        title: extractedTitle,
                        description: desc,
                        location: location,
                        isSelected: index == selectedIndex,
                        rating: dep.rating,
                        onTap: () {
                          setState(() => selectedIndex = index);
                          if (dep.dep_id != null) {
                            context.read<HomeCubit>().fetchDoctorsByDepartment(
                              dep.dep_id!,
                            );
                          }
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                localeText.centerDoctors,
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            // const SizedBox(height: 1),
            Builder(
              builder: (context) {
                final cubit = context.read<HomeCubit>();
                final doctors =
                    cubit.departmentDoctors[currentDepartment.dep_id];

                if (state is HomeFailure && doctors == null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomErrorWidget(
                      errorMessage: state.errorMessage,
                      onRetry: () {
                        if (currentDepartment.dep_id != null) {
                          cubit.fetchDoctorsByDepartment(
                            currentDepartment.dep_id!,
                          );
                        }
                      },
                    ),
                  );
                }

                if (doctors == null || state is HomeLoading) {
                  final isDarkMode =
                      Theme.of(context).brightness == Brightness.dark;
                  final baseColor = isDarkMode
                      ? Colors.grey[800]!
                      : Colors.grey[300]!;
                  final highlightColor = isDarkMode
                      ? Colors.grey[700]!
                      : Colors.grey[100]!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxis,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                if (doctors.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(localeText.noDoctorsFound),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    itemCount: doctors.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxis,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, idx) {
                      final doc = doctors[idx];
                      return buildDoctorCard(context, doc, isGridView: true);
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  IconData _getDepartmentIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('أسنان') || lowerTitle.contains('dent')) {
      return Symbols.dentistry;
    } else if (lowerTitle.contains('قلب') || lowerTitle.contains('cardi')) {
      return Symbols.cardiology;
    } else if (lowerTitle.contains('أطفال') ||
        lowerTitle.contains('pediatric')) {
      return Symbols.child_care;
    } else if (lowerTitle.contains('جلدية') ||
        lowerTitle.contains('dermatology')) {
      return Symbols.face;
    } else if (lowerTitle.contains('عظام') ||
        lowerTitle.contains('orthopedic')) {
      return Symbols.body_system;
    } else if (lowerTitle.contains('عصبية') ||
        lowerTitle.contains('neurology')) {
      return Symbols.neurology;
    } else if (lowerTitle.contains('عيون') ||
        lowerTitle.contains('ophthalmology')) {
      return Symbols.visibility;
    } else if (lowerTitle.contains('جراحة') || lowerTitle.contains('surgery')) {
      return Symbols.local_hospital;
    } else if (lowerTitle.contains('باطنية') ||
        lowerTitle.contains('internal')) {
      return Symbols.medical_services;
    } else if (lowerTitle.contains('أذن') || lowerTitle.contains('ent')) {
      return Symbols.earbuds;
    } else if (lowerTitle.contains('توليد') ||
        lowerTitle.contains('gynecology') ||
        lowerTitle.contains('نساء')) {
      return Symbols.pregnant_woman;
    } else if (lowerTitle.contains('نفسية') || lowerTitle.contains('psych')) {
      return Symbols.psychology;
    }
    return Symbols.medical_services;
  }
}
