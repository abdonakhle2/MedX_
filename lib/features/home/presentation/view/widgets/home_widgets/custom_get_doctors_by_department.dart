import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:project_1/models/clinic.dart';

class CustomGetDoctorsByDept extends StatefulWidget {
  const CustomGetDoctorsByDept({super.key});

  @override
  State<CustomGetDoctorsByDept> createState() => _CustomGetDoctorsByDeptState();
}

class _CustomGetDoctorsByDeptState extends State<CustomGetDoctorsByDept> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // جلب قائمة العيادات عند فتح الصفحة
    context.read<HomeCubit>().fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final allClinics = context.read<HomeCubit>().clinics;

        // فلترة المراكز بناءً على اسم المركز
        List<ClinicModel> displayedClinics = allClinics;

        if (searchQuery.isNotEmpty) {
          final query = searchQuery.toLowerCase();
          displayedClinics = allClinics.where((clinic) {
            return clinic.name_en.toLowerCase().contains(query) ||
                clinic.name_ar.toLowerCase().contains(query);
          }).toList();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "المراكز الطبية", // يمكنك استبدالها بـ localeText.homeMedicalCenters
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "ابحث عن مركز طبي...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color(0xFF1E293B)
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // عرض المراكز
            if (state is HomeLoading && allClinics.isEmpty)
              const Center(child: CircularProgressIndicator())
            else if (displayedClinics.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("لا توجد مراكز مطابقة للبحث"),
              )
            else
              SizedBox(
                height: 150,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: displayedClinics.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final clinic = displayedClinics[index];
                    return Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppShadows.cardShadow,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_hospital,
                            size: 40,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isArabic ? clinic.name_ar : clinic.name_en,
                            textAlign: TextAlign.center,
                            style: AppFonts.labelMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
