import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/widgets/custom_button.dart';

class CustomLogInButton extends StatelessWidget {
  const CustomLogInButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomButton(
      text: localeText.buttonLogin,
      onTap: onTap,
      color: AppColors.primary,
    );
  }
}
