import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';

class CustomAddressTextField extends StatelessWidget {
  const CustomAddressTextField({super.key, required this.addressController});
  final TextEditingController addressController;
  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: addressController,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.registerAddress;
        }
        return null;
      },
      decoration: buildInputDecoration(
        context: context,
        hintText: '722 Marble Arch, West District, London, UK',
        icon: Symbols.location_on,
      ),
    );
  }
}
