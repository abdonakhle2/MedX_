import 'package:flutter/material.dart';

class NavCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const NavCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: isDarkMode 
              ? colorScheme.surface.withOpacity(0.85)
              : colorScheme.surface.withOpacity(0.75),
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(
              color: colorScheme.onSurface.withOpacity(isDarkMode ? 0.2 : 0.1),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(isDarkMode ? 0.15 : 0.06),
                blurRadius: 20.0,
                spreadRadius: -5.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
