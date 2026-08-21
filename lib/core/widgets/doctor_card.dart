import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/models/doctor.dart';

String _getDoctorImageUrl(Doctor doctor) {
  if (doctor.photo.isNotEmpty) {
    if (doctor.photo.startsWith('http')) {
      return doctor.photo;
    }
    return 'https://medx.sy/storage/${doctor.photo}';
  }
  return '';
}

Widget buildDoctorCard(
  BuildContext context,
  Doctor doctor, {
  bool isGridView = false,
}) {
  final theme = Theme.of(context);
  final localeText = AppLocalizations.of(context)!;
  final colorScheme = theme.colorScheme;
  final isDarkMode = theme.brightness == Brightness.dark;
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';

  return Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    elevation: 0,
    color: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      // margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: isDarkMode
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : colorScheme.primary.withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: isGridView ? 100 : 160,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(
                        alpha: isDarkMode ? 0.15 : 0.08,
                      ),
                      AppColors.primaryLight.withValues(alpha: 0.04),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _getDoctorImageUrl(doctor).isNotEmpty
                        ? Image.network(
                            _getDoctorImageUrl(doctor),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: isGridView ? 32 : 40,
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            color: colorScheme.primary.withValues(alpha: 0.08),
                            child: Center(
                              child: Icon(
                                Icons.person_rounded,
                                size: isGridView ? 32 : 40,
                                color: colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.08),
                            Colors.black.withOpacity(0.28),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: AppColors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              doctor.rating.toString(),
                              style: AppFonts.labelSmall.copyWith(
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // make lower area flexible so button fits without overflow
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    isArabic ? doctor.name_ar : doctor.name_en,
                    style: AppFonts.labelLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                      fontSize: isGridView ? 14 : 16,
                      letterSpacing: -0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(
                        alpha: isDarkMode ? 0.15 : 0.08,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isArabic
                          ? doctor.specialization_ar
                          : doctor.specialization_en,
                      style: AppFonts.labelSmall.copyWith(
                        color: isDarkMode
                            ? AppColors.primaryLight
                            : colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(
                        alpha: isDarkMode ? 0.15 : 0.08,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "\$${doctor.fee.toString()} / hr",
                      style: AppFonts.labelSmall.copyWith(
                        color: isDarkMode
                            ? AppColors.primaryLight
                            : colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: isGridView ? 32 : 38,
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         AppointmentScreen(myDoctor: doctor),
                            //   ),
                            // );
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kAppointmentScreen, extra: doctor);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: colorScheme.primary,
                            foregroundColor: AppColors.neutral,
                            elevation: 2,
                            shadowColor: colorScheme.primary.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            localeText.doctorBookButton,
                            style: AppFonts.labelMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: isGridView ? 12 : 14,
                              letterSpacing: 0.2,
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
