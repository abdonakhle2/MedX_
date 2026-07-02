import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomBodyButton extends StatelessWidget {
  CustomBodyButton({
    super.key,
    required this.isCenter,
    required this.onChanged,
  });
  final bool isCenter;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDarkMode
            ? colorScheme.surface
            : colorScheme.onSurface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDarkMode ? [] : AppShadows.softShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(isDarkMode ? 0.1 : 0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isCenter ? AppGradients.primaryGradient : null,
                  color: isCenter ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'Center',
                    style: AppFonts.labelLarge.copyWith(
                      color: isCenter
                          ? Colors.white
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged(false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: !isCenter ? AppGradients.primaryGradient : null,
                  color: !isCenter ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'Doctor',
                    style: AppFonts.labelLarge.copyWith(
                      color: !isCenter
                          ? Colors.white
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
