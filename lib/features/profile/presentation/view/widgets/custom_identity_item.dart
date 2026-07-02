import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomIdentityItem extends StatelessWidget {
  const CustomIdentityItem({
    super.key,
    this.highlightColor,
    this.isHighlighted = false,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isHighlighted;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveHighlightColor = highlightColor ?? colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted
                ? effectiveHighlightColor.withOpacity(0.12)
                : colorScheme.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isHighlighted
                ? effectiveHighlightColor
                : colorScheme.onSurface.withOpacity(0.5),
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
                  color: colorScheme.onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppFonts.bodyLarge.copyWith(
                  color: isHighlighted
                      ? effectiveHighlightColor
                      : colorScheme.onSurface,
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
