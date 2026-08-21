import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/models/doctor.dart';

class CustomHeaderText extends StatelessWidget {
  final Doctor doctor;

  const CustomHeaderText({super.key, required this.doctor});

  String _getDoctorImageUrl() {
    if (doctor.photo.isNotEmpty) {
      if (doctor.photo.startsWith('http')) return doctor.photo;
      return 'https://medx.sy/storage/${doctor.photo}';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final doctorName = isArabic ? doctor.name_ar : doctor.name_en;
    final specialization = isArabic
        ? doctor.specialization_ar
        : doctor.specialization_en;
    final imageUrl = _getDoctorImageUrl();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor photo
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: AppGradients.primaryGradient,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName.isNotEmpty ? doctorName : 'Dr. —',
                  style: AppFonts.headlineSmall.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                if (specialization.isNotEmpty)
                  Text(
                    specialization,
                    style: AppFonts.bodyMedium.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                // if (doctor.fee.toString().isNotEmpty) ...[
                //   const SizedBox(height: 6),
                //   Row(
                //     children: [
                //       Icon(
                //         Icons.access_time_rounded,
                //         size: 14,
                //         color: colorScheme.onSurface.withValues(alpha: 0.5),
                //       ),
                //       const SizedBox(width: 4),
                //       Expanded(
                //         child: Text(
                //           '${localeText.bookingWithDoctorPrefix} ${doctor.work_hours}',
                //           style: AppFonts.bodySmall.copyWith(
                //             color: colorScheme.onSurface.withValues(alpha: 0.6),
                //           ),
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   ),
                // ],
                if (doctor.fee > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money_rounded,
                        size: 14,
                        color: colorScheme.primary.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${doctor.fee.toString()} / hr',
                        style: AppFonts.labelSmall.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
