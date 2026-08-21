import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.obscurePassword,
    required this.onToggleObscure,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final bool obscurePassword;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;

    return TextFormField(
      key: const ValueKey('signup_password'),
      controller: controller,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: 0.5,
      ),
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.passwordRequiredLogin;
        }
        if (value.trim().length < 8) {
          return localeText.passwordLengthLogin;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: localeText.registerMinimumCharacters,
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
        ),
        suffixIcon: IconButton(
          onPressed: onToggleObscure,
          icon: Icon(
            obscurePassword
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
