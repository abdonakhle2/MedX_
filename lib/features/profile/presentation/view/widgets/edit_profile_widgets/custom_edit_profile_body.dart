import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/widgets/custom_upload_id_passport.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_address_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_birthdate_field.dart'
    show CustomBirthdateField;
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_email_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_field_label.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_first_name_text_field.dart'
    show CustomFirstNameTextField;
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_password_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_phone_number_text_field.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_save_changes_button.dart';
import 'package:project_1/models/user.dart';

class CustomEditProfileBody extends StatefulWidget {
  const CustomEditProfileBody({super.key});

  @override
  State<CustomEditProfileBody> createState() => _CustomEditProfileBodyState();
}

class _CustomEditProfileBodyState extends State<CustomEditProfileBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _birthdateController;
  late TextEditingController _addressController;
  late TextEditingController _idPassportController;
  late TextEditingController _passwordController;

  DateTime? _selectedBirthdate;
  @override
  void initState() {
    super.initState();
    final user = User.currentUser;
    _firstNameController = TextEditingController(text: user.firstName);
    _lastNameController = TextEditingController(text: user.lastName);
    _phoneController = TextEditingController(
      text: user.phoneNumber?.toString(),
    );
    _emailController = TextEditingController(text: user.email);
    _addressController = TextEditingController(text: user.address);
    _idPassportController = TextEditingController(
      text: user.idPassport?.toString(),
    );
    _passwordController = TextEditingController(text: user.password);

    _selectedBirthdate = user.birthdate;
    if (_selectedBirthdate != null) {
      _birthdateController = TextEditingController(
        text:
            '${_selectedBirthdate!.year}-${_selectedBirthdate!.month.toString().padLeft(2, '0')}-${_selectedBirthdate!.day.toString().padLeft(2, '0')}',
      );
    } else {
      _birthdateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthdateController.dispose();
    _addressController.dispose();
    _idPassportController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().updateProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        birthdate: _selectedBirthdate,
        address: _addressController.text.trim(),
        idPassport: _idPassportController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppGradients.primaryGradient,
                        boxShadow: AppShadows.softShadow,
                      ),
                      child: Center(
                        child: Icon(
                          Symbols.person_rounded,
                          color: colorScheme.onPrimary,
                          size: 50,
                          fill: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // First Name
              CustomFieldLabel(text: localeText.registerFirstName),
              const SizedBox(height: 8),
              CustomFirstNameTextField(
                firstNameController: _firstNameController,
              ),

              const SizedBox(height: 20),

              // Email Address
              CustomFieldLabel(text: localeText.registerEmailAddressLabel),
              const SizedBox(height: 8),
              CustomEmailTextField(emailController: _emailController),

              const SizedBox(height: 20),

              // Phone Number
              CustomFieldLabel(text: localeText.registerPhoneNumber),
              const SizedBox(height: 8),
              CustomPhoneNumberTextField(phoneController: _phoneController),

              const SizedBox(height: 20),

              // Birthdate
              CustomFieldLabel(text: localeText.profileBirthdate),
              const SizedBox(height: 8),
              CustomBirthdateField(birthdateController: _birthdateController),

              const SizedBox(height: 20),

              // ID / Passport Number
              CustomFieldLabel(text: localeText.profilePassportFile),
              const SizedBox(height: 8),

              CustomUploadIdPassportFile(),
              const SizedBox(height: 20),

              // Address
              CustomFieldLabel(text: localeText.registerAddress),
              const SizedBox(height: 8),
              CustomAddressTextField(addressController: _addressController),

              const SizedBox(height: 20),

              // Password
              CustomFieldLabel(text: localeText.passwordLogin),
              const SizedBox(height: 8),
              CustomPasswordTextField(passwordController: _passwordController),

              const SizedBox(height: 40),
              CustomSaveChangesButton(onPressed: _saveChanges),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
