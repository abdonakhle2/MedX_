import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_identity_item.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_section_header.dart';
import 'package:project_1/models/user.dart';

class CustomIdentityCard extends StatelessWidget {
  const CustomIdentityCard({super.key, required this.user});

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
            title: localeText.profilePersonalIdentity,
            icon: Symbols.manage_accounts,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomIdentityItem(
                  label: localeText.registerGender,
                  value: user.gender ?? '',
                  icon: Symbols.wc,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: colorScheme.onSurface.withOpacity(0.08),
              ),
              Expanded(
                child: CustomIdentityItem(
                  label: localeText.profileAge,
                  value: user.age.toString(),
                  icon: Symbols.cake,
                  isHighlighted: true,
                  highlightColor: colorScheme.primary,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              color: colorScheme.onSurface.withOpacity(0.08),
              height: 1,
            ),
          ),
          CustomIdentityItem(
            label: localeText.profileBirthdate,
            value: user.formattedBirthdate,
            icon: Symbols.calendar_month,
          ),
        ],
      ),
    );
  }
}
