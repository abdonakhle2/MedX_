import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:glass_liquid_navbar/glass_liquid_navbar.dart';

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
    // Check the current theme brightness to determine the highest contrast color
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentColor = isDark ? Colors.white : Colors.black;
    final unselectedContentColor = isDark
        ? Colors.white.withOpacity(0.6)
        : Colors.black.withOpacity(0.6);

    return LiquidGlassNavbar(
      currentIndex: currentIndex,
      onTap: onTap,
      isFullWidth: false,
      showLabels: true,
      theme: LiquidGlassTheme(
        glassColor: Colors.white.withOpacity(0.02), // Less opaque color
        glassBlur: 15.0, // Less blur for more transparency
        glassBorderColor: Colors.white.withOpacity(0.1),
        selectedColor: contentColor,
        unselectedColor: unselectedContentColor,
      ),
      items: const [
        LiquidNavItem(icon: Symbols.home_app_logo, label: 'Home'),
        LiquidNavItem(icon: Symbols.manage_search, label: 'Search'),
        LiquidNavItem(icon: Symbols.calendar_today, label: 'Bookings'),
        LiquidNavItem(icon: Symbols.person, label: 'Profile'),
      ],
    );
  }
}
