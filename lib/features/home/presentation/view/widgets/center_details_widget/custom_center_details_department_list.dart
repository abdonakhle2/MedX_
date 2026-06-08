import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_department_card.dart';

class CustomCenterDetailsDepartmentList extends StatelessWidget {
  const CustomCenterDetailsDepartmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return CustomDepartmentCard(
              icon: Symbols.dentistry,
              title: 'Department ${index + 1}',
              description: 'Dental Care in the MedX Institute',
            );
          },
        ),
      ),
    );
  }
}
