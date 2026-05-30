import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_department_card.dart';

class CustomCenterDetailsDepartmentList extends StatelessWidget {
  const CustomCenterDetailsDepartmentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        5,
        (index) => TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 15 * (1 - value)),
                child: child,
              ),
            );
          },
          child: CustomDepartmentCard(
            icon: Symbols.dentistry,
            title: 'Department ${index + 1}',
            description: 'Dental Care in the MedX Institute',
          ),
        ),
      ),
    );
  }
}
