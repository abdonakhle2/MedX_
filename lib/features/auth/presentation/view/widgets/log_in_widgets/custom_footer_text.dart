import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomFooterText extends StatelessWidget {
  const CustomFooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.grey.shade300],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "NEW TO THE PLATFORM?",
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.secondary,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade300, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
