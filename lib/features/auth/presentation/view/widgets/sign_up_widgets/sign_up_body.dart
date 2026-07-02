import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/build_field_label.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/build_step_indiactor.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_sing_up_app_bar.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_tail_text_sign_up.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_upload_id_passport.dart';
import 'package:project_1/models/user.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> genderFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<PlatformFile?>> uploadFieldKey =
      GlobalKey<FormFieldState<PlatformFile?>>();
  int currentStep = 0;
  String? selectedGender;
  late User user;
  PlatformFile? uploadedPassportFile;
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  DateTime? selectedBirthdate;

  @override
  void initState() {
    super.initState();
    user = User();
  }

  @override
  void dispose() {
    birthdateController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: SingUpBody(context),
      ),
    );
  }

  Widget SingUpBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: CustomSignUpAppBar()),
        const SizedBox(height: 25),
        // Step indicators
        CustomStepIndicator(),
        const SizedBox(height: 30),
        // Form container
        SingUpForm(context),
        // Security note
        const SizedBox(height: 24),
        // Footer
        const CustomTailTextSignUp(),
      ],
    );
  }

  Widget BuildGenderOption(BuildContext context, String gender, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
            user.gender = selectedGender!;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.primaryGradient : null,
            color: isSelected ? null : colorScheme.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : colorScheme.onSurface.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: isSelected ? AppShadows.elevatedShadow : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                gender,
                style: AppFonts.labelLarge.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SingUpForm(BuildContext context) {
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
              const BuildFieldLabel(text: 'First Name'),
              const SizedBox(height: 10),
              CustomFirstNameTextField(context),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Last Name'),
              const SizedBox(height: 10),
              CustomLastNameTextField(context),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Email Address'),
              const SizedBox(height: 10),
              CustomEmailAddressTextField(context),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Phone Number'),
              const SizedBox(height: 10),
              CustomPhoneNumberTextField(context),
            ] else if (currentStep == 1) ...[
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Gender'),
              const SizedBox(height: 10),
              FormField<String>(
                key: genderFieldKey,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please select your gender';
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
                                  selectedGender = 'Male';
                                  user.gender = selectedGender!;
                                  field.didChange(selectedGender);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  gradient: selectedGender == 'Male'
                                      ? AppGradients.primaryGradient
                                      : null,
                                  color: selectedGender == 'Male'
                                      ? null
                                      : colorScheme.onSurface.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selectedGender == 'Male'
                                        ? Colors.transparent
                                        : colorScheme.onSurface.withOpacity(
                                            0.1,
                                          ),
                                    width: 1,
                                  ),
                                  boxShadow: selectedGender == 'Male'
                                      ? AppShadows.elevatedShadow
                                      : [],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.male_rounded,
                                      size: 20,
                                      color: selectedGender == 'Male'
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurface.withOpacity(
                                              0.6,
                                            ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Male',
                                      style: AppFonts.labelLarge.copyWith(
                                        color: selectedGender == 'Male'
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurface,
                                        fontWeight: selectedGender == 'Male'
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
                                  selectedGender = 'Female';
                                  user.gender = selectedGender!;
                                  field.didChange(selectedGender);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  gradient: selectedGender == 'Female'
                                      ? AppGradients.primaryGradient
                                      : null,
                                  color: selectedGender == 'Female'
                                      ? null
                                      : colorScheme.onSurface.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: selectedGender == 'Female'
                                        ? Colors.transparent
                                        : colorScheme.onSurface.withOpacity(
                                            0.1,
                                          ),
                                    width: 1,
                                  ),
                                  boxShadow: selectedGender == 'Female'
                                      ? AppShadows.elevatedShadow
                                      : [],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.female_rounded,
                                      size: 20,
                                      color: selectedGender == 'Female'
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurface.withOpacity(
                                              0.6,
                                            ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Female',
                                      style: AppFonts.labelLarge.copyWith(
                                        color: selectedGender == 'Female'
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurface,
                                        fontWeight: selectedGender == 'Female'
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
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Birthdate'),
              const SizedBox(height: 10),
              CustomBirthDateTextField(context),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Address'),
              const SizedBox(height: 10),
              CustomAddressTextField(context),
            ] else if (currentStep == 2) ...[
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'ID / Passport Number'),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              FormField<PlatformFile?>(
                key: uploadFieldKey,
                initialValue: uploadedPassportFile,
                validator: (value) {
                  if (value == null) {
                    return 'Please upload your ID/passport image';
                  }
                  return null;
                },
                builder: (field) {
                  return CustomUploadIdPassportFile(
                    selectedFile: field.value,
                    errorText: field.errorText,
                    onFileSelected: (file) {
                      setState(() {
                        uploadedPassportFile = file;
                      });
                      field.didChange(file);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Password'),
              const SizedBox(height: 10),
              CustomPasswordTextField(context),
              const SizedBox(height: 20),
              const BuildFieldLabel(text: 'Confirm Password'),
              const SizedBox(height: 10),
              CustomConfirmPasswordTextField(context),
            ],
            const SizedBox(height: 28),
            // Action button
            CustomNextButton(context),
            if (currentStep > 0) ...[
              const SizedBox(height: 12),
              CustomBackButton(context),
            ],
            if (currentStep == 0) ...[const SizedBox(height: 12)],
          ],
        ),
      ),
    );
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          selectedBirthdate ??
          DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: 'DD-MM-YYYY',
      helpText: 'Select birthdate',
    );

    if (pickedDate != null) {
      setState(() {
        selectedBirthdate = pickedDate;
        birthdateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
        user.birthdate = pickedDate;
      });
    }
  }

  Center CustomBackButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            currentStep--;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              color: colorScheme.onSurface.withOpacity(0.6),
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              "Back",
              style: AppFonts.labelLarge.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox CustomNextButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            if (currentStep < 2) {
              setState(() {
                currentStep++;
              });
            } else {
              GoRouter.of(
                context,
              ).pushReplacement(AppRouter.kHomeScreen, extra: user.name);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentStep == 2 ? "Verify" : "Next",
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
                currentStep == 2
                    ? Icons.check_rounded
                    : Icons.arrow_forward_rounded,
                color: colorScheme.onPrimary,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField CustomConfirmPasswordTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_confirm_password'),
      controller: confirmPasswordController,
      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: 0.5,
      ),
      obscureText: obscureConfirmPassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (data) {
        user.confirm_password = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please confirm your password';
        }
        if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Retype your password',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureConfirmPassword = !obscureConfirmPassword;
            });
          },
          icon: Icon(
            obscureConfirmPassword
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  TextFormField CustomPasswordTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_password'),
      controller: passwordController,
      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: 0.5,
      ),
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (data) {
        user.password = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a password';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Minimum 8 characters',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  TextFormField CustomAddressTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_address'),
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      onChanged: (data) {
        user.address = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Damascus, Syria',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.location_on_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  TextFormField CustomBirthDateTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_birthdate'),
      controller: birthdateController,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      readOnly: true,
      keyboardType: TextInputType.datetime,
      onTap: () => _pickBirthdate(context),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please select your birthdate';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: '10-07-1990',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.calendar_today_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  Row CustomGenderOption() {
    return Row(
      children: [
        BuildGenderOption(context, 'Male', Icons.male_rounded),
        const SizedBox(width: 14),
        BuildGenderOption(context, 'Female', Icons.female_rounded),
      ],
    );
  }

  Row CustomPhoneNumberTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colorScheme.onSurface.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              "+963",
              style: AppFonts.labelLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            key: const ValueKey('signup_phone'),
            style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (data) {
              user.phone_number = int.tryParse(data) ?? 0;
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.trim().length < 7) {
                return 'Enter a valid phone number';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: '094 123 456',
              hintStyle: AppFonts.bodyMedium.copyWith(
                color: colorScheme.onSurface.withOpacity(0.4),
              ),
              suffixIcon: Icon(
                Icons.phone_rounded,
                color: colorScheme.onSurface.withOpacity(0.4),
                size: 20,
              ),
              filled: true,
              fillColor: colorScheme.onSurface.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: colorScheme.onSurface.withOpacity(0.1),
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: colorScheme.error, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextFormField CustomEmailAddressTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_email'),
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      keyboardType: TextInputType.emailAddress,
      onChanged: (data) {
        user.email = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        }
        final emailPattern = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+");
        if (!emailPattern.hasMatch(value.trim())) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'ahmad@example.com',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.email_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  TextFormField CustomFirstNameTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_first_name'),
      controller: firstNameController,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (data) {
        user.firstName = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your first name';
        }
        if (value.trim().length < 2) {
          return 'Please enter a valid first name';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Ahmad',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.person_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  TextFormField CustomLastNameTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('signup_last_name'),
      controller: lastNameController,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (data) {
        user.lastName = data;
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your last name';
        }
        if (value.trim().length < 2) {
          return 'Please enter a valid last name';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Al-Faraj',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.person_outline_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }

  Row CustomStepIndicator() {
    return Row(
      children: [
        BuildStepIndiactor(
          title: 'BASIC INFO',
          isActive: currentStep >= 0,
          step: 0,
        ),
        const SizedBox(width: 8),
        BuildStepIndiactor(
          title: 'CREDENTIALS',
          isActive: currentStep >= 1,
          step: 1,
        ),
        const SizedBox(width: 8),
        BuildStepIndiactor(
          title: 'VERIFICATION',
          isActive: currentStep >= 2,
          step: 2,
        ),
      ],
    );
  }
}
