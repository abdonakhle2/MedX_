import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.color, this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
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
