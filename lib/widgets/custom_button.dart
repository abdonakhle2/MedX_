import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.color, this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: AppFonts.labelLarge.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
