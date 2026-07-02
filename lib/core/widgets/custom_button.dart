import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.color, this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: colorScheme.onPrimary.withOpacity(0.2),
        highlightColor: colorScheme.onPrimary.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            gradient: color != null ? null : AppGradients.primaryGradient,
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppShadows.elevatedShadow,
          ),
          child: Container(
            width: double.infinity,
            height: 56,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: AppFonts.labelLarge.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
