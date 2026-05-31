import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

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
    final backgroundColor = widget.isDarkMode
        ? const Color(0xff1d2337)
        : const Color(0xffe2e5ec);
    final toggleColor = widget.isDarkMode
        ? const Color(0xffffffff)
        : const Color(0xffffffff);
    final iconColor = widget.isDarkMode
        ? const Color(0xff22283a)
        : const Color(0xfff3b63a);
    final iconData = widget.isDarkMode
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    return GestureDetector(
      onTap: () {
        widget.onThemeChanged(!widget.isDarkMode);
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
            color: widget.isDarkMode
                ? AppColors.white.withOpacity(0.1)
                : AppColors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: widget.isDarkMode
              ? Alignment.centerRight
              : Alignment.centerLeft,
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
                    color: Colors.black.withOpacity(0.15),
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
