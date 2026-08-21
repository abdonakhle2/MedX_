import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_birthdate_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_field_label.dart';
import 'package:project_1/models/user.dart';

class EditProfileIdentityDialog extends StatefulWidget {
  final User user;

  const EditProfileIdentityDialog({super.key, required this.user});

  @override
  State<EditProfileIdentityDialog> createState() =>
      _EditProfileIdentityDialogState();
}

class _EditProfileIdentityDialogState extends State<EditProfileIdentityDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _birthdateController;
  late TextEditingController _genderController;
  DateTime? _selectedBirthdate;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedBirthdate = widget.user.birthdate;
    _selectedGender = widget.user.gender;
    if (_selectedBirthdate != null) {
      _birthdateController = TextEditingController(
        text:
            '${_selectedBirthdate!.year}-${_selectedBirthdate!.month.toString().padLeft(2, '0')}-${_selectedBirthdate!.day.toString().padLeft(2, '0')}',
      );
    } else {
      _birthdateController = TextEditingController();
    }
    _genderController = TextEditingController(text: widget.user.gender);
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      DateTime? parsedDate;
      try {
        if (_birthdateController.text.isNotEmpty) {
          parsedDate = DateTime.parse(_birthdateController.text);
        }
      } catch (e) {}
      
      context.read<UpdateCubit>().updateProfile(
        firstName: widget.user.firstName ?? '',
        lastName: widget.user.lastName ?? '',
        email: widget.user.email ?? '',
        phone: widget.user.phoneNumber ?? '',
        birthdate: parsedDate ?? _selectedBirthdate ?? DateTime.now(),
        address: widget.user.address ?? '',
        gender: _selectedGender ?? '',
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
                          localeText.profilePersonalIdentity,
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
                  CustomFieldLabel(text: localeText.profileBirthdate),
                  const SizedBox(height: 8),
                  CustomBirthdateField(
                    birthdateController: _birthdateController,
                  ),
                  const SizedBox(height: 20),
                  CustomFieldLabel(text: localeText.registerGender),
                  const SizedBox(height: 8),
                  FormField<String>(
                    initialValue: _selectedGender,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return localeText.registerSelectGender;
                      }
                      return null;
                    },
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGender = 'male';
                                      _genderController.text = 'male';
                                      field.didChange('male');
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: _selectedGender == 'male'
                                          ? AppGradients.primaryGradient
                                          : null,
                                      color: _selectedGender == 'male'
                                          ? null
                                          : colorScheme.onSurface.withOpacity(
                                              0.05,
                                            ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: _selectedGender == 'male'
                                            ? Colors.transparent
                                            : colorScheme.onSurface.withOpacity(
                                                0.1,
                                              ),
                                        width: 1,
                                      ),
                                      boxShadow: _selectedGender == 'male'
                                          ? AppShadows.elevatedShadow
                                          : [],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.male_rounded,
                                          size: 20,
                                          color: _selectedGender == 'male'
                                              ? colorScheme.onPrimary
                                              : colorScheme.onSurface
                                                    .withOpacity(0.6),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          localeText.registerMale,
                                          style: AppFonts.labelLarge.copyWith(
                                            color: _selectedGender == 'male'
                                                ? colorScheme.onPrimary
                                                : colorScheme.onSurface,
                                            fontWeight:
                                                _selectedGender == 'male'
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedGender = 'female';
                                      _genderController.text = 'female';
                                      field.didChange('female');
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: _selectedGender == 'female'
                                          ? AppGradients.primaryGradient
                                          : null,
                                      color: _selectedGender == 'female'
                                          ? null
                                          : colorScheme.onSurface.withOpacity(
                                              0.05,
                                            ),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: _selectedGender == 'female'
                                            ? Colors.transparent
                                            : colorScheme.onSurface.withOpacity(
                                                0.1,
                                              ),
                                        width: 1,
                                      ),
                                      boxShadow: _selectedGender == 'female'
                                          ? AppShadows.elevatedShadow
                                          : [],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.female_rounded,
                                          size: 20,
                                          color: _selectedGender == 'female'
                                              ? colorScheme.onPrimary
                                              : colorScheme.onSurface
                                                    .withOpacity(0.6),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          localeText.registerFemale,
                                          style: AppFonts.labelLarge.copyWith(
                                            color: _selectedGender == 'female'
                                                ? colorScheme.onPrimary
                                                : colorScheme.onSurface,
                                            fontWeight:
                                                _selectedGender == 'female'
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 4),
                              child: Text(
                                field.errorText ?? '',
                                style: AppFonts.bodySmall.copyWith(
                                  color: colorScheme.error,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
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
