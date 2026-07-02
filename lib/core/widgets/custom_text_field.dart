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
    this.hintLetterSpacing,
    this.labelLetterSpacing,
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
  final double? hintLetterSpacing;
  final double? labelLetterSpacing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      cursorColor: colorScheme.primary,
      cursorRadius: const Radius.circular(2),

      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: hintLetterSpacing,
        fontSize: 16,
      ),

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
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),

        labelText: labelText,
        labelStyle: TextStyle(
          color: colorScheme.primary,
          letterSpacing: labelLetterSpacing,
        ),

        suffixIcon: suffixIcon,

        prefixIcon: prefixText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Text(
                  prefixText!,
                  style: AppFonts.labelLarge.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,

        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        filled: true,
        fillColor: isDarkMode ? colorScheme.surface : AppColors.greyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDarkMode 
              ? colorScheme.onSurface.withOpacity(0.2)
              : colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }
}
