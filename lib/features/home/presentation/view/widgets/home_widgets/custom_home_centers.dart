import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_list.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_stats.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_get_doctors_by_department.dart';

class CustomHomeCenters extends StatelessWidget {
  const CustomHomeCenters({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const CustomGetDoctorsByDept(),
          const SizedBox(height: 24),
          Text(
            localeText.homeMedicalCenters,
            style: AppFonts.headlineMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          const CustomHomeList(),
          // const SizedBox(height: 10),
          const CustomHomeStats(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}
