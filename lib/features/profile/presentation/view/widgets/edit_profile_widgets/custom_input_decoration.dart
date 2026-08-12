import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

InputDecoration buildInputDecoration({
  required BuildContext context,
  required String hintText,
  required IconData icon,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  return InputDecoration(
    hintText: hintText,
    hintStyle: AppFonts.bodyMedium.copyWith(
      color: colorScheme.onSurface.withOpacity(0.4),
    ),
    prefixIcon: Icon(
      icon,
      color: colorScheme.onSurface.withOpacity(0.4),
      size: 22,
    ),
    filled: true,
    fillColor: colorScheme.onSurface.withOpacity(0.05),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withOpacity(0.1),
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: colorScheme.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: colorScheme.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
  );
}
