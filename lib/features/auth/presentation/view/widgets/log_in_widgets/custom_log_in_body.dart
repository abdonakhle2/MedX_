import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/app_router.dart';
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

  void submitLogin() {
    if (formKey.currentState?.validate() ?? false) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      //   (route) => false,
      // );
      GoRouter.of(context).pushReplacement(AppRouter.kHomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
        boxShadow: AppShadows.cardShadow,
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
              Text('Welcome Back', style: AppFonts.headlineLarge),
              const SizedBox(height: 20),
              // Phone Number
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: AppFonts.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
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
                    'Password',
                    style: AppFonts.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
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
                    'Forgot Password?',
                    style: AppFonts.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomLogInButton(onTap: submitLogin),
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
  }
}
