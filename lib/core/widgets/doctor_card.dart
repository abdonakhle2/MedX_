import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/models/doctor.dart';

Widget buildDoctorCard(
  BuildContext context,
  Doctor doctor, {
  bool isGridView = false,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isDarkMode = theme.brightness == Brightness.dark;
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
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: isDarkMode
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.15),
          width: 1.5,
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
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_rounded,
                          size: isGridView ? 32 : 40,
                          color: colorScheme.primary.withValues(alpha: 0.3),
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
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isDarkMode ? [] : AppShadows.softShadow,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: AppColors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "4.9",
                              style: AppFonts.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                                fontSize: 10,
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
                    doctor.name_en,
                    style: AppFonts.labelLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                      fontSize: isGridView ? 14 : 16,
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
                      doctor.specialization,
                      style: AppFonts.labelSmall.copyWith(
                        color: isDarkMode
                            ? AppColors.primaryLight
                            : colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${doctor.hourly_rate}',
                        style: AppFonts.labelLarge.copyWith(
                          color: isDarkMode
                              ? AppColors.primaryLight
                              : colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: isGridView ? 14 : 16,
                        ),
                      ),
                      Text(
                        '/hr',
                        style: AppFonts.labelSmall.copyWith(
                          color: isDarkMode
                              ? const Color(0xFF94A3B8)
                              : AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
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
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Book",
                            style: AppFonts.labelMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: isGridView ? 12 : 14,
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
