import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

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
            children: [
              _buildStatItem(
                '500+',
                'SPECIALISTS',
                Icons.medical_services_rounded,
              ),
              _buildDivider(),
              _buildStatItem('15', 'DISTRICTS', Icons.location_city_rounded),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('24/7', 'SUPPORT', Icons.support_agent_rounded),
              _buildDivider(),
              _buildStatItem('4.8', 'AVG RATING', Icons.star_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.white.withOpacity(0.2),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.6), size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppFonts.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppFonts.labelSmall.copyWith(
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 1.2,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
