import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';

class CustomCreateAccountButton extends StatelessWidget {
  const CustomCreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localeText.dontHaveAccountLogin,
          style: AppFonts.bodyMedium.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSignUpScreen);
          },
          child: Text(
            localeText.createAccountLogin,
            style: AppFonts.labelLarge.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
