import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/app_router.dart';

class CustomCreateAccountButton extends StatelessWidget {
  const CustomCreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
        ),
        TextButton(
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => SignUpScreen()),
            // );
            GoRouter.of(context).push(AppRouter.kSignUpScreen);
          },
          child: Text(
            'Create Account',
            style: AppFonts.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
