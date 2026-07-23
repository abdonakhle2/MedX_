import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_contact_row.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_section_header.dart';
import 'package:project_1/models/user.dart';

class CustomContactCard extends StatelessWidget {
  const CustomContactCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.06),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            title: localeText.profileContactInfo,
            icon: Symbols.contact_mail,
          ),
          const SizedBox(height: 24),
          CustomContactRow(
            icon: Symbols.mail,
            label: localeText.registerEmailAddressLabel,
            value: user.email ?? '',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: colorScheme.onSurface.withOpacity(0.08),
              height: 1,
            ),
          ),
          CustomContactRow(
            icon: Symbols.call,
            label: localeText.registerPhoneNumber,
            value: user.phone_number != null
                ? '\u200E+963 ${user.phone_number}'
                : '',
          ),
        ],
      ),
    );
  }
}
