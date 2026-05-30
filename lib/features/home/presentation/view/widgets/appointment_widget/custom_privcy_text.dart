import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_show_policy_dialog.dart';

class CustomPrivcyText extends StatelessWidget {
  const CustomPrivcyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: 'By confirming, you agree to our ',
        style: AppFonts.bodySmall.copyWith(color: AppColors.secondary),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary.withOpacity(0.3),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                CustomShowPolicyDialog(
                  context,

                  "Terms of Service",
                  "1. User must be 18+ years old.\n"
                      "2. Accurate information is required.\n"
                      "3. Cancellations must be 24h prior.",
                );
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary.withOpacity(0.3),
            ),
            // عند الضغط على "Privacy Policy"
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                CustomShowPolicyDialog(
                  context,
                  "Privacy Policy",
                  "• We value your health data privacy.\n"
                      "• Data is encrypted and secured.\n"
                      "• We do not share data with third parties.",
                );
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
