import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';
import 'package:project_1/core/widgets/custom_button.dart';

class CustomLogInButton extends StatelessWidget {
  const CustomLogInButton({super.key, required this.onTap});

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Login',
      onTap: onTap,
      //() {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeScreen()),
      //   );
      // },
      color: AppColors.primary,
    );
  }
}
