import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class BuildFooterItem extends StatelessWidget {
  const BuildFooterItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurface.withOpacity(0.4)),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: colorScheme.onSurface.withOpacity(0.4),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
