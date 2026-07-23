import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/widgets/glass_card.dart';
import 'package:project_1/constants/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: NavCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              Symbols.home_app_logo,
              localeText.navHome,
              0,
            ),
            _buildNavItem(
              context,
              Symbols.favorite,
              localeText.navFavorites,
              1,
            ),
            _buildNavItem(
              context,
              Symbols.manage_search,
              localeText.navSearch,
              2,
            ),
            _buildNavItem(
              context,
              Symbols.calendar_today,
              localeText.navBookings,
              3,
            ),
            _buildNavItem(context, Symbols.person, localeText.navProfile, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = currentIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primaryGradient : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimary
                  : AppColors.secondary.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppFonts.labelSmall.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : AppColors.secondary.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 9,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
