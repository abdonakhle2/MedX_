import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class BuildFooterItem extends StatelessWidget {
  const BuildFooterItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.secondary.withOpacity(0.5)),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: AppColors.secondary.withOpacity(0.5),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
