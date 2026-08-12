import 'package:flutter/material.dart';

class CustomThemeModeSwitch extends StatefulWidget {
  const CustomThemeModeSwitch({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<CustomThemeModeSwitch> createState() => _CustomThemeModeSwitchState();
}

class _CustomThemeModeSwitchState extends State<CustomThemeModeSwitch> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? colorScheme.surface.withOpacity(0.8)
        : colorScheme.surface;
    final toggleColor = colorScheme.surface;
    final iconColor = isDarkMode ? Colors.amber : Colors.amber;
    final iconData = isDarkMode
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    return GestureDetector(
      onTap: () {
        widget.onThemeChanged(!isDarkMode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 60,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: toggleColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(iconData, size: 16, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
