import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_appointment_body.dart';
import 'package:project_1/features/home/presentation/view/widgets/appointment_widget/custom_app_bar.dart';
import 'package:project_1/models/doctor.dart';

class AppointmentBody extends StatelessWidget {
  final Doctor myDoctor;

  const AppointmentBody({super.key, required this.myDoctor});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomAppBar(),
        CustomAppointmentBody(myDoctor: myDoctor),
      ],
    );
  }
}
