import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Symbols.date_range, color: AppColors.primary),
        SizedBox(width: 8),
        Text(
          'Book with ClinicName :',
          style: AppFonts.headlineSmall.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        // Icon(Symbols.book, color: AppColors.primary),
      ],
    );
  }
}
