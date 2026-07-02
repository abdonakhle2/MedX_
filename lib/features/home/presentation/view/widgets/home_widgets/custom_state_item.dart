import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomStateItem extends StatelessWidget {
  const CustomStateItem({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppFonts.headlineSmall.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppFonts.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
              letterSpacing: 1.2,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
