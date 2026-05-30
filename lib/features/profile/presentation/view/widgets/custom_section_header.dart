import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 22, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppFonts.headlineSmall.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
