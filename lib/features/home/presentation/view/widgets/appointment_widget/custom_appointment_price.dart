import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_price_row.dart';
import 'package:project_1/models/doctor.dart';

class CustomAppointmentPrice extends StatelessWidget {
  final Doctor doctor;
  final double? appointmentFee;
  const CustomAppointmentPrice({
    super.key,
    required this.doctor,
    this.appointmentFee,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;

    final double feeToDisplay = appointmentFee ?? doctor.fee;
    const double platformFee = 0.0;
    final double total = feeToDisplay + platformFee;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colorScheme.surface,
        boxShadow: isDarkMode ? [] : AppShadows.softShadow,
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.payment_sharp, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                localeText.bookingPaymentDetails,
                style: AppFonts.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomPriceRow(
            label: localeText.bookingConsultationFee,
            price: feeToDisplay,
          ),
          if (platformFee > 0) ...[
            const SizedBox(height: 14),
            CustomPriceRow(
              label: localeText.bookingPlatformFee,
              price: platformFee,
            ),
          ],
          const SizedBox(height: 14),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  colorScheme.onSurface.withValues(alpha: 0.15),
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
                '\$${total.toStringAsFixed(2)}',
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
