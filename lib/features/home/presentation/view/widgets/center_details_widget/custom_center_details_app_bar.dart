import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomCenterDetailsAppBar extends StatelessWidget {
  const CustomCenterDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return SliverAppBar(
      // backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? AppGradients.primaryDarkGradient
                  : AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.local_hospital_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            localeText.centerDetailsTitle,
            style: AppFonts.headlineMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E293B) : AppColors.greyLight,
            borderRadius: BorderRadius.circular(10),
            border: isDarkMode
                ? Border.all(
                    color: colorScheme.onSurface.withValues(alpha: 0.05),
                    width: 1,
                  )
                : null,
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
