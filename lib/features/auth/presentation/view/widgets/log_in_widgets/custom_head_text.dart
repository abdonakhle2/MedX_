import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomHeadText extends StatelessWidget {
  const CustomHeadText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Human-Centric Authority in Healthcare.',
      style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
    );
  }
}
