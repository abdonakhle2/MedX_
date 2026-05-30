import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_appointment_body.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_app_bar.dart';

class AppointmentBody extends StatelessWidget {
  const AppointmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [const CustomAppBar(), const CustomAppointmentBody()],
    );
  }
}
