import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomDepartmentCard extends StatelessWidget {
  const CustomDepartmentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.location,
    required this.rating,
    this.isSelected = false,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final String location;
  final double rating;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final borderColor = isSelected
        ? colorScheme.primary.withValues(alpha: 0.5)
        : colorScheme.onSurface.withValues(alpha: 0.05);

    final bgColor = isSelected
        ? colorScheme.primary.withValues(alpha: isDarkMode ? 0.12 : 0.04)
        : (isDarkMode
              ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.2)
              : Colors.white);

    return Card(
      margin: const EdgeInsets.only(right: 12),
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap ?? () {},
          child: Container(
            width: 290,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black12
                      : colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: borderColor,
                width: isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: isSelected
                          ? (isDarkMode
                                ? AppColors.primaryLight
                                : colorScheme.primary)
                          : colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.labelLarge.copyWith(
                          color: isSelected
                              ? (isDarkMode
                                    ? AppColors.primaryLight
                                    : AppColors.primaryDark)
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: AppFonts.bodyMedium.copyWith(
                    color: isDarkMode
                        ? const Color(0xFFCBD5E1)
                        : AppColors.black.withValues(alpha: 0.7),
                    height: 1.4,
                    fontSize: 13.5,
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.bodySmall.copyWith(
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    // 3. عرض قيمة التقييم القادمة ديناميكياً مع استخدام toStringAsFixed لعرض رقم عشري واحد
                    Text(
                      '${rating.toStringAsFixed(1)} ${localeText.centerRating}',
                      style: AppFonts.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
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
