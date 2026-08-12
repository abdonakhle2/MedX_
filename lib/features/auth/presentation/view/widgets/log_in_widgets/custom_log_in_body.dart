import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/Custom_log_in_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_create_account_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_footer_text.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_password_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_email_text_field.dart';

import 'package:project_1/models/user.dart';

class CustomLogInBody extends StatefulWidget {
  const CustomLogInBody({super.key});

  @override
  State<CustomLogInBody> createState() => _CustomLogInBodyState();
}

class _CustomLogInBodyState extends State<CustomLogInBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitLogin(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      BlocProvider.of<LoginCubit>(context).userLogin(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          customSnackBar(
            context,
            'welcomeBack, ${state.user.name}',
            backgroundColor: Colors.green,
          );
          GoRouter.of(context).pushReplacement(AppRouter.kHomeScreen);
        } else if (state is LoginFailure) {
          customSnackBar(
            context,
            state.errorMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: colorScheme.surface,
            boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
            border: isDarkMode
                ? Border.all(
                    color: colorScheme.onSurface.withOpacity(0.08),
                    width: 1.5,
                  )
                : null,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              24,
            ).copyWith(bottom: 24 + MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Welcome Header
                  // const SizedBox(height: 20),
                  Text(
                    localeText.welcomeBackLogin,
                    style: AppFonts.headlineLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Phone Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        localeText.emailLogin,
                        style: AppFonts.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomEmailTextField(
                    controller: emailController,
                    onChanged: (value) {
                      user?.email = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        localeText.passwordLogin,
                        style: AppFonts.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordTextField(
                    controller: passwordController,
                    onChanged: (value) {
                      user?.password = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        localeText.forgotPasswordLogin,
                        style: AppFonts.labelMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomLogInButton(
                    isLoading: state is LoginLoading,
                    onTap: () => submitLogin(context),
                  ),
                  const SizedBox(height: 24),
                  // Divider
                  CustomFooterText(),

                  const SizedBox(height: 16),
                  CustomCreateAccountButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
