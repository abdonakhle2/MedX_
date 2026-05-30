import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';
import 'package:project_1/widgets/custom_button.dart';

class CustomLogInButton extends StatelessWidget {
  const CustomLogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Login',
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      color: AppColors.primary,
    );
  }
}
