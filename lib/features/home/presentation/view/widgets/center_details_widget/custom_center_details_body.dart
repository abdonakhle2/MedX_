import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_about.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_department_list.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_header_image.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_location.dart';
import 'package:project_1/models/clinic.dart';

class CustomCenterDetailsBody extends StatelessWidget {
  final ClinicModel clinic;
  const CustomCenterDetailsBody({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCenterDetailsHeaderImage(clinic: clinic),
            const SizedBox(height: 20),
            CustomCenterDetailsAbout(clinic: clinic),
            const SizedBox(height: 20),
            CustomCenterDetailsLocation(clinic: clinic),
            const SizedBox(height: 28),
            CustomCenterDetailsDepartmentList(clinic: clinic),
          ],
        ),
      ),
    );
  }
}
