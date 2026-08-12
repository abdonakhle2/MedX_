import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';

class CustomPhoneNumberTextField extends StatelessWidget {
  const CustomPhoneNumberTextField({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              controller: phoneController,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return localeText.registerInvalidPhone;
                }
                if (value.trim().length < 9) {
                  return localeText.registerInvalidPhone;
                }
                return null;
              },
              decoration: buildInputDecoration(
                context: context,
                hintText: '999999999',
                icon: Symbols.call,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
