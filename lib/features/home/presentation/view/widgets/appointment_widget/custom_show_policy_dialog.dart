import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

void CustomShowPolicyDialog(BuildContext context, String title, String rules) {
  final colorScheme = Theme.of(context).colorScheme;
  final localeText = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                title.contains(localeText.termsTitle)
                    ? Icons.description_rounded
                    : Icons.shield_rounded,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppFonts.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            rules,
            style: AppFonts.bodyMedium.copyWith(
              height: 1.6,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                localeText.termsUnderstandButton,
                style: AppFonts.labelLarge.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
