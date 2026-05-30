import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_divider.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_state_item.dart';

class CustomHomeStats extends StatelessWidget {
  const CustomHomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.headerGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.elevatedShadow,
      ),
      child: Column(
        children: [
          Text(
            'OUR NETWORK',
            style: AppFonts.labelSmall.copyWith(
              color: Colors.white.withOpacity(0.7),
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              CustomStateItem(
                value: '500+',
                label: 'SPECIALISTS',
                icon: Icons.medical_services_rounded,
              ),
              CustomDivider(),
              CustomStateItem(
                value: '15',
                label: 'DISTRICTS',
                icon: Icons.location_city_rounded,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              CustomStateItem(
                value: '24/7',
                label: 'SUPPORT',
                icon: Icons.support_agent_rounded,
              ),
              CustomDivider(),
              CustomStateItem(
                value: '4.8',
                label: 'AVG RATING',
                icon: Icons.star_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
