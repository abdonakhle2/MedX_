import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_1/constants/constants.dart';

class CustomFieldLabel extends StatelessWidget {
  const CustomFieldLabel({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      text,
      style: AppFonts.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }
}
