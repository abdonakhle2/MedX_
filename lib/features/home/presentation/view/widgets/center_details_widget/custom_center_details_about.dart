import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/models/clinic.dart';

class CustomCenterDetailsAbout extends StatelessWidget {
  final ClinicModel clinic;
  const CustomCenterDetailsAbout({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isDarkMode ? null : AppGradients.surfaceGradient,
        borderRadius: BorderRadius.circular(24),
        color: isDarkMode ? colorScheme.surface : null,
        border: Border.all(
          color: isDarkMode
              ? const Color(0xFF334155)
              : AppColors.primary.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.primaryLight.withOpacity(0.15)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: isDarkMode
                      ? AppColors.primaryLight
                      : AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                localeText.centerAboutTitle,
                style: AppFonts.headlineSmall.copyWith(
                  color: isDarkMode
                      ? AppColors.primaryLight
                      : AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            Localizations.localeOf(context).languageCode == 'ar' &&
                    clinic.description_ar.isNotEmpty
                ? clinic.description_ar
                : clinic.description_en.isNotEmpty
                ? clinic.description_en
                : 'No description available.',
            style: AppFonts.bodyMedium.copyWith(
              color: isDarkMode ? const Color(0xFF94A3B8) : AppColors.secondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.phone, color: colorScheme.primary),
              SizedBox(width: 8),
              Text(
                clinic.phone_number,
                style: AppFonts.bodyMedium.copyWith(color: colorScheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
