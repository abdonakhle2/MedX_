import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_divider.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_state_item.dart';

class CustomHomeStats extends StatelessWidget {
  const CustomHomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? AppGradients.primaryDarkGradient
            : AppGradients.headerGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.elevatedShadow,
      ),
      child: Column(
        children: [
          Text(
            localeText.homeOurNetwork,
            style: AppFonts.labelSmall.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.6 : 0.7),
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CustomStateItem(
                value: '500+',
                label: localeText.homeSpecialists,
                icon: Icons.medical_services_rounded,
              ),
              CustomDivider(),
              CustomStateItem(
                value: '15',
                label: localeText.homeDistricts,
                icon: Icons.location_city_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CustomStateItem(
                value: '24/7',
                label: localeText.homeSupport,
                icon: Icons.support_agent_rounded,
              ),
              CustomDivider(),
              CustomStateItem(
                value: '4.8',
                label: localeText.homeAvgRating,
                icon: Icons.star_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
