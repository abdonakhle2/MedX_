import 'package:flutter/material.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/build_step_indiactor.dart';

class CustomStepIndicatorRow extends StatelessWidget {
  const CustomStepIndicatorRow({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return Row(
      children: [
        BuildStepIndiactor(
          title: localeText.registerTabBasicInfo,
          isActive: currentStep >= 0,
          step: 0,
        ),
        const SizedBox(width: 8),
        BuildStepIndiactor(
          title: localeText.registerTabCredentials,
          isActive: currentStep >= 1,
          step: 1,
        ),
        const SizedBox(width: 8),
        BuildStepIndiactor(
          title: localeText.registerTabVerification,
          isActive: currentStep >= 2,
          step: 2,
        ),
      ],
    );
  }
}
