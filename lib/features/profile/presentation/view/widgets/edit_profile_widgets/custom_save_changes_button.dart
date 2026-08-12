import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_state.dart';

class CustomSaveChangesButton extends StatelessWidget {
  const CustomSaveChangesButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isUpdating = state is ProfileUpdating;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isUpdating ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isUpdating
                ? CircularProgressIndicator(color: colorScheme.onPrimary)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localeText.editProfileSaveChanges,
                        style: AppFonts.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: colorScheme.onPrimary,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
