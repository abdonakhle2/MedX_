import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localeText.ratingSubmit,
              style: AppFonts.labelLarge.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.send_rounded, color: colorScheme.onPrimary, size: 20),
          ],
        ),
      ),
    );
  }
}
