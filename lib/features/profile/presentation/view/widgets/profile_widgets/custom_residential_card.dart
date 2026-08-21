import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/edit_profile_address_dialog.dart';
import 'package:project_1/models/user.dart';

class CustomResidentialCard extends StatelessWidget {
  const CustomResidentialCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localeText.profileResidential,
                style: AppFonts.labelSmall.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.75),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                ),
              ),
              IconButton(
                onPressed: () => _showEditAddressDialog(context),
                icon: Icon(Symbols.edit, color: colorScheme.onPrimary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Symbols.location_on,
                  color: colorScheme.onPrimary,
                  size: 24,
                  fill: 1.0,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  user.address ?? '',
                  style: AppFonts.bodyLarge.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showEditAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<UpdateCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: EditProfileAddressDialog(user: user),
      ),
    );
  }
}
