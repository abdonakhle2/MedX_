import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/localization/cubit/loacale_cubit.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

void CustomLanguageDialog(BuildContext context) {
  final localeText = AppLocalizations.of(context)!;
  String selectedLanguageCode = context.read<LocaleCubit>().state.languageCode;

  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(localeText.profileLanguageTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: Text(localeText.englishSplash),
                  value: 'en',
                  groupValue: selectedLanguageCode,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      selectedLanguageCode = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(localeText.arabicSplash),
                  value: 'ar',
                  groupValue: selectedLanguageCode,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      selectedLanguageCode = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(localeText.bookingsCancel),
              ),
              FilledButton(
                onPressed: () {
                  context.read<LocaleCubit>().changeLanguage(
                    selectedLanguageCode,
                  );
                  Navigator.of(dialogContext).pop();
                },
                child: Text(localeText.confirmButton),
              ),
            ],
          );
        },
      );
    },
  );
}
