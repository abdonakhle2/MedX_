import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;

  const CustomOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: isActive ? AppGradients.primaryGradient : null,
        color: isActive ? null : colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isActive
            ? AppShadows.elevatedShadow
            : (isDarkMode ? [] : AppShadows.softShadow),
        border: !isActive
            ? Border.all(
                color: colorScheme.onSurface.withOpacity(0.08),
                width: 1,
              )
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : colorScheme.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.bodyLarge.copyWith(
                    color: isActive ? Colors.white : colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppFonts.bodySmall.copyWith(
                    color: isActive
                        ? Colors.white.withOpacity(0.7)
                        : colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? Colors.white.withOpacity(0.5)
                    : colorScheme.onSurface.withOpacity(0.2),
                width: 2,
              ),
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: isActive
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : const SizedBox(width: 16, height: 16),
          ),
        ],
      ),
    );
  }
}
