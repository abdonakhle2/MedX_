import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomInfoBadge extends StatelessWidget {
  const CustomInfoBadge({super.key, required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppFonts.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
