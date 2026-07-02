import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomDepartmentCard extends StatelessWidget {
  const CustomDepartmentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isSelected = false,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final borderColor = isSelected
        ? colorScheme.primary
        : (isDarkMode
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
              : Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.12));
    final bgColor = isSelected
        ? colorScheme.primary.withValues(alpha: isDarkMode ? 0.15 : 0.06)
        : colorScheme.surface;
    return Card(
      margin: const EdgeInsets.only(right: 12),
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap:
              onTap ??
              () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const DepartmentScreen(),
                //   ),
                // );
              },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 250,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: bgColor,
              boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
              border: Border.all(
                color: borderColor,
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary.withValues(
                              alpha: isDarkMode ? 0.25 : 0.16,
                            ),
                            colorScheme.primary.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: isDarkMode
                            ? AppColors.primaryLight
                            : colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppFonts.headlineSmall.copyWith(
                              color: isSelected
                                  ? (isDarkMode
                                        ? AppColors.primaryLight
                                        : AppColors.primaryDark)
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? const Color(0xFF94A3B8)
                                  : AppColors.secondary,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(
                          alpha: isDarkMode ? 0.15 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.people_rounded,
                            size: 16,
                            color: isDarkMode
                                ? AppColors.primaryLight
                                : AppColors.primaryDark,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '12 Doctors',
                            style: AppFonts.bodySmall.copyWith(
                              color: isDarkMode
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF1E293B)
                            : AppColors.greyLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '4.9 Rating',
                            style: AppFonts.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
