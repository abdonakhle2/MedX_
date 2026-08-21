import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_field_label.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_first_name_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';
import 'package:project_1/models/user.dart';

class EditProfileNameDialog extends StatefulWidget {
  final User user;

  const EditProfileNameDialog({super.key, required this.user});

  @override
  State<EditProfileNameDialog> createState() => _EditProfileNameDialogState();
}

class _EditProfileNameDialogState extends State<EditProfileNameDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<UpdateCubit>().updateProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: widget.user.email ?? '',
        phone: widget.user.phoneNumber ?? '',
        birthdate: widget.user.birthdate ?? DateTime.now(),
        address: widget.user.address ?? '',
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
                        localeText.profileEditTitle,
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
                CustomFieldLabel(text: localeText.registerFirstName),
                const SizedBox(height: 8),
                CustomFirstNameTextField(
                  firstNameController: _firstNameController,
                ),
                const SizedBox(height: 20),
                CustomFieldLabel(text: localeText.registerLastName),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameController,
                  style: AppFonts.bodyMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localeText.registerLastNameRequired;
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(
                    context: context,
                    hintText: localeText.registerLastNameExample,
                    icon: Symbols.person,
                  ),
                ),
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
