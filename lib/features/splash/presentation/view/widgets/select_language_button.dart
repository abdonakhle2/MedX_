import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class LanguageChip extends StatelessWidget {
  const LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : (isDarkMode
                    ? const Color(0xFF0F172A).withOpacity(0.5)
                    : AppColors.white),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : (isDarkMode
                      ? Colors.transparent
                      : colorScheme.onSurface.withOpacity(0.12)),
          ),
        ),
        child: Text(
          label,
          style: AppFonts.bodyMedium.copyWith(
            color: selected ? AppColors.white : colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
