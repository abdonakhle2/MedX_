import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_tail_text_sign_up.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/custom_step_indicator_row.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/sign_up_form_widget.dart';

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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _syncUserData() {
    user.firstName = firstNameController.text.trim();
    user.lastName = lastNameController.text.trim();
    user.email = emailController.text.trim();
    user.phoneNumber = phoneController.text.trim();
    user.gender = selectedGender ?? '';
    user.birthdate = selectedBirthdate;
    user.address = addressController.text.trim();
    user.password = passwordController.text;
    user.confirmPassword = confirmPasswordController.text;
    if (uploadedPassportFile != null && uploadedPassportFile!.path != null) {
      user.idPassport = File(uploadedPassportFile!.path!);
    }
  }

  Future<void> _pickBirthdate(BuildContext context) async {
    final localeText = AppLocalizations.of(context)!;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          selectedBirthdate ??
          DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldHintText: 'DD-MM-YYYY',
      helpText: localeText.registerSelectBirthdate,
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // context.read<ProfileCubit>().updateUserCache(state.user);
          context.read<ProfileCubit>().refreshProfile();
          print('User Info: ${user.toJson()}');
          print('Uploaded Passport File: ${user.idPassport}');
          customSnackBar(
            context,
            'welcome, ${user.name}',
            backgroundColor: Colors.green,
          );
          GoRouter.of(
            context,
          ).pushReplacement(AppRouter.kHomeScreen, extra: state.user.firstName);
        } else if (state is RegisterFailure) {
          customSnackBar(
            context,
            state.errorMessage,
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicators
                CustomStepIndicatorRow(currentStep: currentStep),
                const SizedBox(height: 30),
                // Form container
                SignUpFormWidget(
                  formKey: formKey,
                  currentStep: currentStep,
                  state: state,
                  user: user,
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  genderFieldKey: genderFieldKey,
                  selectedGender: selectedGender,
                  onGenderSelected: (gender) {
                    setState(() {
                      selectedGender = gender;
                      user.gender = gender;
                    });
                  },
                  birthdateController: birthdateController,
                  onPickBirthdate: () => _pickBirthdate(context),
                  addressController: addressController,
                  uploadFieldKey: uploadFieldKey,
                  uploadedPassportFile: uploadedPassportFile,
                  onFileSelected: (file) {
                    setState(() {
                      uploadedPassportFile = file;
                    });
                  },
                  passwordController: passwordController,
                  obscurePassword: obscurePassword,
                  onToggleObscurePassword: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  confirmPasswordController: confirmPasswordController,
                  obscureConfirmPassword: obscureConfirmPassword,
                  onToggleObscureConfirmPassword: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  onNext: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (currentStep < 2) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        _syncUserData();
                        context.read<RegisterCubit>().registerUser(
                          user: user,
                          passportFile: uploadedPassportFile,
                        );
                      }
                    }
                  },
                  onBack: () {
                    setState(() {
                      currentStep--;
                    });
                  },
                ),
                // Security note
                const SizedBox(height: 24),
                // Footer
                const CustomTailTextSignUp(),
              ],
            ),
          ),
        );
      },
    );
  }
}
