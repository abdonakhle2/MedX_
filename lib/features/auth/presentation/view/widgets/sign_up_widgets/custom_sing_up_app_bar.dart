import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomSignUpAppBar extends StatelessWidget {
  const CustomSignUpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back),
            color: AppColors.primary,
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.local_hospital_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'MedX',
            style: AppFonts.headlineMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
