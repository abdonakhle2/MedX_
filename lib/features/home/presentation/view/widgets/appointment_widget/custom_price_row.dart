import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomPriceRow extends StatelessWidget {
  const CustomPriceRow({super.key, required this.label, required this.price});

  final String label;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: AppFonts.bodyLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
