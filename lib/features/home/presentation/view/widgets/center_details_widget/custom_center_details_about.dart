import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomCenterDetailsAbout extends StatelessWidget {
  const CustomCenterDetailsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.surfaceGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'About the Institute',
                style: AppFonts.headlineSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'At Harborview, we redefine clinical excellence through an editorial lens. Our facility combines state-of-the-art diagnostic technology...',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.secondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
