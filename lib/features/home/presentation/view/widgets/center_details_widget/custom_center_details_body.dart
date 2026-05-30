import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_about.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_department_list.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_header_image.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_location.dart';

class CustomCenterDetailsBody extends StatelessWidget {
  const CustomCenterDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            CustomCenterDetailsHeaderImage(),
            SizedBox(height: 20),
            CustomCenterDetailsAbout(),
            SizedBox(height: 20),
            CustomCenterDetailsLocation(),
            SizedBox(height: 28),
            CustomCenterDetailsDepartmentList(),
          ],
        ),
      ),
    );
  }
}
