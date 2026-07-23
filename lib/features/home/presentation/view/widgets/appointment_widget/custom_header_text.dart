import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${localeText.bookingWithDoctorPrefix} Elite Medical Clinic',
            style: AppFonts.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ahmad ali',
            style: AppFonts.bodyMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Cardiology',
            style: AppFonts.bodyMedium.copyWith(
              color: colorScheme.primary.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
