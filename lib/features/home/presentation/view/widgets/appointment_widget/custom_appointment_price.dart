import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_price_row.dart';

class CustomAppointmentPrice extends StatelessWidget {
  const CustomAppointmentPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colorScheme.surface,
        boxShadow: isDarkMode ? [] : AppShadows.softShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.payment_sharp, color: colorScheme.primary, size: 20),
              SizedBox(width: 8),
              Text(
                localeText.bookingPaymentDetails,
                style: AppFonts.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: 14),
          CustomPriceRow(
            label: localeText.bookingConsultationFee,
            price: 200.0,
          ),
          const SizedBox(height: 14),
          CustomPriceRow(label: localeText.bookingPlatformFee, price: 150.0),
          const SizedBox(height: 14),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  colorScheme.onSurface.withOpacity(0.15),
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
                localeText.bookingTotalCash,
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                '\$200.00',
                style: AppFonts.headlineSmall.copyWith(
                  color: colorScheme.primary,
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
