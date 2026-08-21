import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;

    return SliverAppBar(
      backgroundColor: isDarkMode
          ? const Color(0xFF0F172A)
          : colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
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
              color: colorScheme.onPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            localeText.bookingAppointmentTitle,
            style: AppFonts.headlineMedium.copyWith(
              color: isDarkMode
                  ? colorScheme.primaryContainer
                  : colorScheme.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF1E293B)
                : colorScheme.onSurface.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: isDarkMode
                ? colorScheme.primaryContainer
                : colorScheme.primary,
            size: 18,
          ),
        ),
      ),
      // 🟢 إضافة زر الإشعارات هنا للانتقال لشاشة الإشعارات
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
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: isDarkMode
                    ? colorScheme.primaryContainer
                    : colorScheme.primary,
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
