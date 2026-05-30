import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_app_bar.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_center_details_body.dart';

class CenterDetailsBody extends StatelessWidget {
  const CenterDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [CustomCenterDetailsAppBar(), CustomCenterDetailsBody()],
    );
  }
}
