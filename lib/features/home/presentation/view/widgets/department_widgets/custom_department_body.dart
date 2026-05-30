import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/department_widgets/custom_department_header.dart';
import 'package:project_1/features/home/presentation/view/widgets/department_widgets/custom_doctor_grid_view.dart';

class CustomDepartmentBody extends StatelessWidget {
  const CustomDepartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 18),
            CustomDepartmentHeader(),
            SizedBox(height: 32),
            CustomDoctorGridView(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
