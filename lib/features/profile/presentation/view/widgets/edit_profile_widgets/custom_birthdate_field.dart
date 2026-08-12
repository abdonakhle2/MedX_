import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';

class CustomBirthdateField extends StatefulWidget {
  const CustomBirthdateField({super.key, required this.birthdateController});
  final TextEditingController birthdateController;

  @override
  State<CustomBirthdateField> createState() => _CustomBirthdateFieldState();
}

class _CustomBirthdateFieldState extends State<CustomBirthdateField> {
  DateTime? _selectedBirthdate;
  Future<void> _pickBirthdate(BuildContext context) async {
    final localeText = AppLocalizations.of(context)!;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: localeText.registerSelectBirthdate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        widget.birthdateController.text =
            '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.birthdateController,
      readOnly: true,
      onTap: () => _pickBirthdate(context),
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.registerSelectBirthdate;
        }
        return null;
      },
      decoration: buildInputDecoration(
        context: context,
        hintText: 'Oct 24, 1992',
        icon: Symbols.calendar_month,
      ),
    );
  }
}
