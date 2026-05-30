import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_list.dart';

import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_stats.dart';

class CustomHomeCenters extends StatelessWidget {
  const CustomHomeCenters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Medical Centers', style: AppFonts.headlineMedium),
          const SizedBox(height: 20),
          const CustomHomeList(),
          const SizedBox(height: 30),
          const CustomHomeStats(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
