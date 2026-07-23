import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomHeadText extends StatelessWidget {
  const CustomHeadText({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return Text(
      localeText.humanCentricLogin,
      style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
    );
  }
}
