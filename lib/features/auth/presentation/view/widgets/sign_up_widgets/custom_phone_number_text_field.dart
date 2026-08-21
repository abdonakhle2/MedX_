import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomPhoneNumberTextField extends StatelessWidget {
  const CustomPhoneNumberTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: colorScheme.onSurface.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                "+963",
                textDirection: TextDirection.ltr,
                style: AppFonts.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              key: const ValueKey('signup_phone'),
              controller: controller,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localeText.registerEnterPhone;
                }
                if (!value.trim().startsWith('9')) {
                  return localeText.phoneStartWith9;
                }
                if (value.trim().length < 9) {
                  return localeText.registerInvalidPhone;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '094 123 456',
                hintTextDirection: TextDirection.ltr,
                hintStyle: AppFonts.bodyMedium.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
                suffixIcon: Icon(
                  Icons.phone_rounded,
                  color: colorScheme.onSurface.withOpacity(0.4),
                  size: 20,
                ),
                filled: true,
                fillColor: colorScheme.onSurface.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}
