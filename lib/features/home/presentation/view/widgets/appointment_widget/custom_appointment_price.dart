import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_price_row.dart';

class CustomAppointmentPrice extends StatelessWidget {
  const CustomAppointmentPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: [
          const CustomPriceRow(label: 'Consultation Fee', price: 200.0),
          const SizedBox(height: 14),
          const CustomPriceRow(label: 'Digital Platform Fee', price: 150.0),
          const SizedBox(height: 14),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.greyLight,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total cash',
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '\$200.00',
                style: AppFonts.headlineSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
