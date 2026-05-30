import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Symbols.date_range, color: AppColors.primary),
          SizedBox(width: 8),
          Text(
            'Selection Method',
            style: AppFonts.headlineSmall.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
