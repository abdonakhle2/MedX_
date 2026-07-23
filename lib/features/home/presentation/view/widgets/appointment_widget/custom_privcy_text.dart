import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_show_policy_dialog.dart';

class CustomPrivcyText extends StatelessWidget {
  const CustomPrivcyText({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: localeText.bookingTermsAgreementPrefix,
        style: AppFonts.bodySmall.copyWith(
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
        children: [
          TextSpan(
            text: localeText.bookingTermsOfService,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.primary.withOpacity(0.3),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                CustomShowPolicyDialog(
                  context,
                  localeText.bookingTermsOfService,
                  "${localeText.termsRule1}\n"
                  "${localeText.termsRule2}\n"
                  "${localeText.termsRule3}",
                );
              },
          ),
          TextSpan(text: localeText.bookingAndConjunction),
          TextSpan(
            text: localeText.bookingPrivacyPolicy,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.primary.withOpacity(0.3),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                CustomShowPolicyDialog(
                  context,
                  localeText.bookingPrivacyPolicy,
                  "${localeText.privacyRule1}\n"
                  "${localeText.privacyRule2}\n"
                  "${localeText.privacyRule3}",
                );
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
