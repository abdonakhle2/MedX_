import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomCenterDetailsHeaderImage extends StatelessWidget {
  const CustomCenterDetailsHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[300],
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1588776814546-9b1c8e5f0a3c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG9zcGl0YWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: AppShadows.cardShadow,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoBadge('4.5 ⭐', 'EXPERIENCE'),
                    VerticalDivider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 1,
                      indent: 2,
                      endIndent: 2,
                    ),
                    _buildInfoBadge('8 AM - 8 PM', 'OPERATING HOURS'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppFonts.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
