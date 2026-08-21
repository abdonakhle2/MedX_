import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // تأكد من استيراد GoRouter
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart'; // تأكد من استيراد AppRouter الخاص بك
import 'package:project_1/models/clinic.dart';

class CustomCenterDetailsAppBar extends StatelessWidget {
  final ClinicModel clinic;
  const CustomCenterDetailsAppBar({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              Localizations.localeOf(context).languageCode == 'ar' &&
                      clinic.name_ar.isNotEmpty
                  ? clinic.name_ar
                  : clinic.name_en,
              style: AppFonts.headlineMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
              overflow: TextOverflow.ellipsis,
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
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E293B)
                    : AppColors.greyLight,
                borderRadius: BorderRadius.circular(10),
                border: isDarkMode
                    ? Border.all(
                        color: colorScheme.onSurface.withValues(alpha: 0.05),
                        width: 1,
                      )
                    : null,
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
            ),
            onPressed: () {
              context.push(AppRouter.kNotificationsScreen);
            },
          ),
        ),
      ],
    );
  }
}
