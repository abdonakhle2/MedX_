import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/Custom_log_in_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_create_account_button.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_footer_text.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_password_text_field.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_phone_number_text_field.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';

class CustomLogInBody extends StatefulWidget {
  const CustomLogInBody({super.key});

  @override
  State<CustomLogInBody> createState() => _CustomLogInBodyState();
}

class _CustomLogInBodyState extends State<CustomLogInBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitLogin() {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
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
                    'Phone Number',
                    style: AppFonts.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomPhoneNumberTextField(controller: phoneController),
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
              CustomPasswordTextField(controller: passwordController),
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
