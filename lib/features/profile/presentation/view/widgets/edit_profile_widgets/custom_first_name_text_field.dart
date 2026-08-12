import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';

class CustomFirstNameTextField extends StatelessWidget {
  const CustomFirstNameTextField({
    super.key,
    required,
    required this.firstNameController,
  });
  final TextEditingController firstNameController;
  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: firstNameController,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.registerFirstNameRequired;
        }
        return null;
      },
      decoration: buildInputDecoration(
        context: context,
        hintText: localeText.registerFirstNameExample,
        icon: Symbols.person,
      ),
    );
  }
}
