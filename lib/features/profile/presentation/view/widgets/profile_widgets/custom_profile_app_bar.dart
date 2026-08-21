import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/theme/cubit/theme_cubit.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_theme_mode_switch.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final isDarkMode = context.watch<ThemeCubit>().isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      elevation: 0,
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Symbols.person, color: colorScheme.onPrimary, size: 18),
          ),
          const SizedBox(width: 10),
          Text(
            localeText.profileTitle,
            style: AppFonts.headlineMedium.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 10),
          child: CustomThemeModeSwitch(
            isDarkMode: isDarkMode,
            onThemeChanged: (value) {
              context.read<ThemeCubit>().toggleThemeMode(value);
            },
          ),
        ),
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
