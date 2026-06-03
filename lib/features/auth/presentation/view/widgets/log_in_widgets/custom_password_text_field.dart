import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({super.key, this.controller, this.validator});

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,

      style: AppFonts.bodyMedium.copyWith(
        color: AppColors.black,
        letterSpacing: 0.5,
      ),
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (data) {},
      decoration: InputDecoration(
        hintText: '*****',
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: AppColors.secondary.withOpacity(0.5),
          letterSpacing: 3,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: AppColors.secondary.withOpacity(0.5),
          ),
        ),
        filled: true,
        fillColor: AppColors.greyLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }
}
