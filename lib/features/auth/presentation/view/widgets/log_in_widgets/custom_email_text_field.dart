import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({
    super.key,
    this.controller,
    required this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: const ValueKey('log_in'),
      controller: controller,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.emailRequiredLogin; // استخدم النص المترجم هنا
        }
        final emailPattern = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+");
        if (!emailPattern.hasMatch(value.trim())) {
          return localeText.emailInvalidLogin; // استخدم النص المترجم هنا
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: localeText.emailExampleLogin,
        hintTextDirection: TextDirection.ltr,
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: Icon(
          Icons.email_rounded,
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
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
            color: colorScheme.onSurface.withOpacity(0.08),
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
