import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/edit_profile_name_dialog.dart';
import 'package:project_1/models/user.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primaryGradient,
              ),
              child: Center(
                child: Icon(
                  Symbols.person_rounded,
                  color: colorScheme.onPrimary,
                  size: 60,
                  fill: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.name ?? '',
              style: AppFonts.headlineLarge.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _showEditNameDialog(context),
              icon: Icon(Symbols.edit, color: colorScheme.primary, size: 28),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Symbols.badge, size: 18, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    '${localeText.profileIdLabel} ${user.id ?? ''}',
                    style: AppFonts.labelLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.amber.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Symbols.workspace_premium,
                    size: 18,
                    color: AppColors.amber,
                    fill: 1.0,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localeText.profileMember,
                    style: AppFonts.labelLarge.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<UpdateCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: EditProfileNameDialog(user: user),
      ),
    );
  }
}
