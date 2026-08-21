import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_section_header.dart';
import 'package:project_1/models/user.dart';

class CustomVerificationCard extends StatelessWidget {
  const CustomVerificationCard({super.key, required this.user});
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
            title: localeText.profileVerificationDocuments,
            icon: Symbols.verified,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localeText.profilePassportFile,
                      style: AppFonts.labelSmall.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.4),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.idPassport.toString(),
                      style: AppFonts.bodyLarge.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Symbols.visibility,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
