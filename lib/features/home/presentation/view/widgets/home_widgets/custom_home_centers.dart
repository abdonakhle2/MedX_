import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/widgets/card_clinic.dart';
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
          const _HomeCenterList(),
          const SizedBox(height: 30),
          const CustomHomeStats(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _HomeCenterList extends StatelessWidget {
  const _HomeCenterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: const CardClinic(),
        );
      },
    );
  }
}
