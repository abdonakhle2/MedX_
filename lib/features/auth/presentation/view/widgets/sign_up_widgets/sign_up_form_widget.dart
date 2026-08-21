import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/core/widgets/custom_upload_id_passport.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/build_field_label.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_first_name_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_last_name_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_email_address_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_phone_number_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_birth_date_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_address_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_password_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_confirm_password_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_next_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_back_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_gender_selection.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
    required this.formKey,
    required this.currentStep,
    required this.state,
    required this.user,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.genderFieldKey,
    required this.selectedGender,
    required this.onGenderSelected,
    required this.birthdateController,
    required this.onPickBirthdate,
    required this.addressController,
    required this.uploadFieldKey,
    required this.uploadedPassportFile,
    required this.onFileSelected,
    required this.passwordController,
    required this.obscurePassword,
    required this.onToggleObscurePassword,
    required this.confirmPasswordController,
    required this.obscureConfirmPassword,
    required this.onToggleObscureConfirmPassword,
    required this.onNext,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final int currentStep;
  final RegisterState state;
  final User user;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  final GlobalKey<FormFieldState<String>> genderFieldKey;
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;

  final TextEditingController birthdateController;
  final VoidCallback onPickBirthdate;

  final TextEditingController addressController;

  final GlobalKey<FormFieldState<PlatformFile?>> uploadFieldKey;
  final PlatformFile? uploadedPassportFile;
  final ValueChanged<PlatformFile?> onFileSelected;

  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onToggleObscurePassword;

  final TextEditingController confirmPasswordController;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleObscureConfirmPassword;

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: isDarkMode
            ? Border.all(color: colorScheme.onSurface.withOpacity(0.08))
            : null,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentStep == 0) ...[
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerFirstName),
              const SizedBox(height: 10),
              CustomFirstNameTextField(
                controller: firstNameController,
                onChanged: (data) => user.firstName = data,
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerLastName),
              const SizedBox(height: 10),
              CustomLastNameTextField(
                controller: lastNameController,
                onChanged: (data) => user.lastName = data,
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerEmailAddressLabel),
              const SizedBox(height: 10),
              CustomEmailAddressTextField(
                controller: emailController,
                onChanged: (data) => user.email = data,
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerPhoneNumber),
              const SizedBox(height: 10),
              CustomPhoneNumberTextField(
                controller: phoneController,
                onChanged: (data) => user.phoneNumber = data.trim(),
              ),
            ] else if (currentStep == 1) ...[
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerGender),
              const SizedBox(height: 10),
              FormField<String>(
                key: genderFieldKey,
                initialValue: selectedGender,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return localeText.registerSelectGender;
                  }
                  return null;
                },
                builder: (field) {
                  return CustomGenderSelection(
                    selectedGender: selectedGender,
                    onGenderSelected: (gender) {
                      onGenderSelected(gender);
                      field.didChange(gender);
                    },
                    errorText: field.errorText,
                  );
                },
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerBirthdate),
              const SizedBox(height: 10),
              CustomBirthDateTextField(
                controller: birthdateController,
                onTap: onPickBirthdate,
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerAddress),
              const SizedBox(height: 10),
              CustomAddressTextField(
                controller: addressController,
                onChanged: (data) => user.address = data,
              ),
            ] else if (currentStep == 2) ...[
              const SizedBox(height: 40),
              FormField<PlatformFile?>(
                key: uploadFieldKey,
                initialValue: uploadedPassportFile,
                validator: (value) {
                  if (value == null) {
                    return localeText.registerUploadID;
                  }
                  return null;
                },
                builder: (field) {
                  return CustomUploadIdPassportFile(
                    selectedFile: field.value,
                    errorText: field.errorText,
                    onFileSelected: (file) {
                      onFileSelected(file);
                      field.didChange(file);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.passwordLogin),
              const SizedBox(height: 10),
              CustomPasswordTextField(
                controller: passwordController,
                onChanged: (data) => user.password = data,
                obscurePassword: obscurePassword,
                onToggleObscure: onToggleObscurePassword,
              ),
              const SizedBox(height: 20),
              BuildFieldLabel(text: localeText.registerConfirmPassword),
              const SizedBox(height: 10),
              CustomConfirmPasswordTextField(
                controller: confirmPasswordController,
                passwordController: passwordController,
                onChanged: (data) => user.confirmPassword = data,
                obscureConfirmPassword: obscureConfirmPassword,
                onToggleObscure: onToggleObscureConfirmPassword,
              ),
            ],
            const SizedBox(height: 28),
            // Action button
            CustomNextButton(
              isLoading: state is RegisterLoading,
              isLastStep: currentStep == 2,
              onPressed: onNext,
            ),
            if (currentStep > 0) ...[
              const SizedBox(height: 12),
              CustomBackButton(onPressed: onBack),
            ],
            if (currentStep == 0) ...[const SizedBox(height: 12)],
          ],
        ),
      ),
    );
  }
}
