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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: isActive ? AppGradients.primaryGradient : null,
        color: isActive ? null : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isActive ? AppShadows.elevatedShadow : AppShadows.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.primary,
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
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppFonts.bodySmall.copyWith(
                    color: isActive
                        ? Colors.white.withOpacity(0.7)
                        : AppColors.secondary,
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
                    : AppColors.greyLight,
                width: 2,
              ),
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: isActive
                ? Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : const SizedBox(width: 16, height: 16),
          ),
        ],
      ),
    );
  }
}
