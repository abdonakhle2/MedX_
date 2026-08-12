import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({super.key, required this.passwordController});
  final TextEditingController passwordController;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isPasswordHidden = false;
  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.passwordController,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      obscureText: _isPasswordHidden,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.passwordRequiredLogin;
        }
        if (value.length < 8) {
          return localeText.registerMinimumCharacters;
        }
        return null;
      },

      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.onSurface.withOpacity(0.05),
        hintText: '**********',
        hintTextDirection: TextDirection.ltr,
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),

        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
