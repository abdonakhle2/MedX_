import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:project_1/widgets/glass_card.dart';
import 'package:project_1/constants/constants.dart';

class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Symbols.home_app_logo, 'HOME', 0),
          _buildNavItem(Symbols.manage_search, 'SEARCH', 1),
          _buildNavItem(Symbols.calendar_today, 'BOOKINGS', 2),
          _buildNavItem(Symbols.person, 'PROFILE', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final iconColor = isSelected
        ? AppColors.primary
        : AppColors.secondary.withOpacity(0.75);
    final labelColor = isSelected
        ? AppColors.primary
        : AppColors.secondary.withOpacity(0.65);
    final backgroundColor = isSelected
        ? AppColors.primary.withOpacity(0.14)
        : Colors.transparent;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppFonts.labelSmall.copyWith(
                color: labelColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
