import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/theme/cubit/theme_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_theme_mode_switch.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onEditPressed});

  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
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
            'Profile',
            style: AppFonts.headlineMedium.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        if (onEditPressed != null)
          IconButton(
            icon: Icon(
              Symbols.edit_square,
              color: colorScheme.primary,
              size: 24,
            ),
            onPressed: onEditPressed,
            tooltip: 'Edit Profile',
          ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CustomThemeModeSwitch(
            isDarkMode: isDarkMode,
            onThemeChanged: (value) {
              context.read<ThemeCubit>().toggleThemeMode(value);
            },
          ),
        ),
      ],
    );
  }
}
