import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class BuildFieldLabel extends StatelessWidget {
  const BuildFieldLabel({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: AppFonts.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }
}
