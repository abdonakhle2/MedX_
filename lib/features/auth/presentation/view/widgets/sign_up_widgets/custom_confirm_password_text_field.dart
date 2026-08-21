import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomConfirmPasswordTextField extends StatelessWidget {
  const CustomConfirmPasswordTextField({
    super.key,
    required this.controller,
    required this.passwordController,
    required this.onChanged,
    required this.obscureConfirmPassword,
    required this.onToggleObscure,
  });

  final TextEditingController controller;
  final TextEditingController passwordController;
  final Function(String) onChanged;
  final bool obscureConfirmPassword;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return TextFormField(
      key: const ValueKey('signup_confirm_password'),
      controller: controller,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: 0.5,
      ),
      obscureText: obscureConfirmPassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.registerConfirmPasswordRequired;
        }
        if (value != passwordController.text) {
          return localeText.registerPasswordsDoNotMatch;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: localeText.registerRetypePassword,
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: IconButton(
          onPressed: onToggleObscure,
          icon: Icon(
            obscureConfirmPassword
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: colorScheme.onSurface.withOpacity(0.4),
          ),
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
            color: colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
      ),
    );
  }
}
