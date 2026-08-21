import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_address_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_field_label.dart';
import 'package:project_1/models/user.dart';

class EditProfileAddressDialog extends StatefulWidget {
  final User user;

  const EditProfileAddressDialog({super.key, required this.user});

  @override
  State<EditProfileAddressDialog> createState() =>
      _EditProfileAddressDialogState();
}

class _EditProfileAddressDialogState extends State<EditProfileAddressDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateCubit>().updateProfile(
        firstName: widget.user.firstName ?? '',
        lastName: widget.user.lastName ?? '',
        email: widget.user.email ?? '',
        phone: widget.user.phoneNumber ?? '',
        birthdate: widget.user.birthdate ?? DateTime.now(),
        address: _addressController.text.trim(),
        gender: widget.user.gender ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;

    return BlocListener<UpdateCubit, UpdateState>(
      listener: (context, state) {
        if (state is UpdateSuccess) {
          customSnackBar(
            context,
            localeText.editProfileUpdateSuccess,
            backgroundColor: Colors.green,
          );
          context.read<ProfileCubit>().refreshProfile();
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        } else if (state is UpdateError) {
          customSnackBar(
            context,
            state.errorMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          localeText.profileResidential,
                          style: AppFonts.headlineMedium.copyWith(
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Symbols.close, color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomFieldLabel(text: localeText.registerAddress),
                  const SizedBox(height: 8),
                  CustomAddressTextField(addressController: _addressController),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(localeText.bookingsCancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BlocBuilder<UpdateCubit, UpdateState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is UpdateLoading
                                  ? null
                                  : _saveChanges,
                              child: state is UpdateLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(localeText.editProfileUpdateSuccess),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
