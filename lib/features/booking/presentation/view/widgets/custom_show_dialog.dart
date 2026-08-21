import 'package:flutter/material.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_rating_card.dart';
import 'package:project_1/models/appointments.dart'; // تأكد من استيراد مودل المواعيد

void ShowSuccessDialog(BuildContext context, Appointments appointment) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      return AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        content: CustomRatingCard(appointment: appointment),
      );
    },
  );
}
