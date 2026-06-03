import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_1/constants/constants.dart';

class CustomPhoneNumberTextField extends StatelessWidget {
  const CustomPhoneNumberTextField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.greyLight,
                AppColors.greyLight.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Center(
            child: Text(
              "+963",
              style: AppFonts.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }

              final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
              if (digits.length < 9 || digits.length > 9) {
                return 'Enter a valid phone number';
              }

              return null;
            },
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.black,
              letterSpacing: 1,
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: '094 123 456',
              hintStyle: AppFonts.bodyMedium.copyWith(
                color: AppColors.secondary.withOpacity(0.5),
                letterSpacing: 1,
              ),
              suffixIcon: Icon(
                Icons.phone_rounded,
                color: AppColors.secondary.withOpacity(0.5),
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
          ),
        ),
      ],
    );
  }
}
