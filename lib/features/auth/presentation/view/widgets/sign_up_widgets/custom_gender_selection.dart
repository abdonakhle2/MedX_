import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomGenderSelection extends StatelessWidget {
  const CustomGenderSelection({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
    this.errorText,
  });

  final String? selectedGender;
  final Function(String) onGenderSelected;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildGenderOption(
              context,
              'male',
              localeText.registerMale,
              Icons.male_rounded,
              colorScheme,
            ),
            const SizedBox(width: 14),
            _buildGenderOption(
              context,
              'female',
              localeText.registerFemale,
              Icons.female_rounded,
              colorScheme,
            ),
          ],
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4),
            child: Text(
              errorText!,
              style: AppFonts.bodySmall.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGenderOption(
    BuildContext context,
    String genderValue,
    String label,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    final isSelected = selectedGender == genderValue;
    return Expanded(
      child: GestureDetector(
        onTap: () => onGenderSelected(genderValue),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.primaryGradient : null,
            color: isSelected ? null : colorScheme.onSurface.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : colorScheme.onSurface.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: isSelected ? AppShadows.elevatedShadow : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppFonts.labelLarge.copyWith(
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
