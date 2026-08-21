import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_app_bar.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_body.dart';
import 'package:project_1/models/clinic.dart';

class CenterDetailsBody extends StatelessWidget {
  final ClinicModel clinic;
  const CenterDetailsBody({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomCenterDetailsAppBar(clinic: clinic),
        CustomCenterDetailsBody(clinic: clinic),
      ],
    );
  }
}
