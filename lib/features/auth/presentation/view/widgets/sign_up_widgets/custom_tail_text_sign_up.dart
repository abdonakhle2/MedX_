import 'package:flutter/material.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/build_footer_item.dart';

class CustomTailTextSignUp extends StatelessWidget {
  const CustomTailTextSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildFooterItem(
            icon: Icons.verified_user_rounded,
            label: localeText.hipaaCompliantLogin,
          ),
          Container(
            width: 1,
            height: 16,
            color: colorScheme.onSurface.withOpacity(0.12),
          ),
          BuildFooterItem(
            icon: Icons.lock_rounded,
            label: localeText.aesEncryptionLogin,
          ),
        ],
      ),
    );
  }
}
