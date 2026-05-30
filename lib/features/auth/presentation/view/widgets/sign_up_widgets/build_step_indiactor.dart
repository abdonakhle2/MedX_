import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class BuildStepIndiactor extends StatelessWidget {
  const BuildStepIndiactor({
    super.key,
    required this.title,
    required this.isActive,
    required this.step,
  });
  final String title;
  final bool isActive;
  final int step;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              gradient: isActive ? AppGradients.primaryGradient : null,
              color: isActive ? null : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(3),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppFonts.labelSmall.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? AppColors.primary : AppColors.secondary,
              letterSpacing: 0.5,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
