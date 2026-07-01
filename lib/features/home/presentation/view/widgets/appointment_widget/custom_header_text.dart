import 'package:flutter/material.dart';

import 'package:project_1/constants/constants.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Book with Elite Medical Clinic',
            style: AppFonts.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ahmad ali',
            style: AppFonts.bodyMedium.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            'Cardiology',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.primary.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
