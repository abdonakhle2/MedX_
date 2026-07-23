import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_info_badge.dart';

class CustomCenterDetailsHeaderImage extends StatelessWidget {
  const CustomCenterDetailsHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.surface,
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1538108149393-fbbd81895907?auto=format&fit=crop&w=1000&q=80',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  isDarkMode
                      ? Colors.black.withOpacity(
                          0.7,
                        ) // تعميق الظل أسفل الصورة ليلاً
                      : Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF0F172A).withOpacity(0.4)
                    : Theme.of(context).colorScheme.surface.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDarkMode
                      ? Theme.of(
                          context,
                        ).colorScheme.onPrimary.withOpacity(0.08)
                      : Theme.of(
                          context,
                        ).colorScheme.onPrimary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomInfoBadge(
                      value: '4.5 ⭐',
                      label: localeText.centerRating,
                    ),
                    VerticalDivider(
                      color: isDarkMode
                          ? Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.15)
                          : Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.3),
                      thickness: 1,
                      indent: 2,
                      endIndent: 2,
                    ),
                    CustomInfoBadge(
                      value: '8 AM - 8 PM',
                      label: localeText.centerOperatingHours,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
