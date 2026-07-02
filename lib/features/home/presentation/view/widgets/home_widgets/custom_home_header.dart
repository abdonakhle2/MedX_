import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/app_router.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppGradients.primaryDarkGradient
              : AppGradients.headerGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: isDarkMode ? [] : AppShadows.elevatedShadow,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.04 : 0.08),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.03 : 0.05),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prioritize Your\nHealth Today',
                    style: AppFonts.headlineLarge.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'You have no upcoming appointments. Schedule a visit to stay on top of your health.',
                    style: AppFonts.bodyMedium.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withOpacity(0.85),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   '/search',
                      //   (route) => false,
                      // );
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kSearchScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? const Color(0xFF1E293B)
                          : Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: isDarkMode
                          ? theme.colorScheme.primary
                          : AppColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Book Appointment',
                          style: AppFonts.labelLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.onSurface
                                : AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
