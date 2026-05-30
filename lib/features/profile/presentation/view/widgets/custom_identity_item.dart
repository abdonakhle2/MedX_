import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomIdentityItem extends StatelessWidget {
  const CustomIdentityItem({
    super.key,
    this.highlightColor = AppColors.primary,
    this.isHighlighted = false,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;
  final bool isHighlighted;
  final Color highlightColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted
                ? highlightColor.withOpacity(0.1)
                : AppColors.greyLight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isHighlighted ? highlightColor : AppColors.greyMedium,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.greyMedium,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppFonts.bodyLarge.copyWith(
                  color: isHighlighted ? highlightColor : AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: isHighlighted ? 22 : 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
