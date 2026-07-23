import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    this.controller,
    required this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localeText.passwordRequiredLogin;
        }
        if (value.length < 8) {
          return localeText.passwordLengthLogin;
        }
        return null;
      },
      style: AppFonts.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        letterSpacing: 0.5,
      ),
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: '*****',
        hintTextDirection: TextDirection.ltr,
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: colorScheme.onSurface.withOpacity(0.4),
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
