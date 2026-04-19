import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_1/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.inputType,
    this.labelText,
    this.suffixIcon,
    this.prefixText,
    this.onlyNumbers = false,
    this.textStyle,
    this.readOnly = false,
    this.onTap,
    this.controller,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final TextInputType? inputType;
  final bool obscureText;
  final String? labelText;
  final Widget? suffixIcon;
  final String? prefixText;
  final bool onlyNumbers;
  final TextStyle? textStyle;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.primary,

      style: AppFonts.bodyMedium.copyWith(color: AppColors.black),

      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: inputType,
      inputFormatters: onlyNumbers
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.bodyMedium.copyWith(color: Colors.grey[500]),

        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.primary),

        suffixIcon: suffixIcon,

        prefixIcon: prefixText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                child: Text(
                  prefixText!,
                  style: AppFonts.labelLarge.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,

        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        filled: true,
        fillColor: AppColors.greyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
    );
  }
}
