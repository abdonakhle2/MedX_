import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class LanguageCheckboxItem extends StatelessWidget {
  const LanguageCheckboxItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onChanged,
  });

  final String title;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => onChanged(!selected),
      // borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.14),
            // width: 0,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Checkbox(
              value: selected,
              onChanged: onChanged,
              activeColor: colorScheme.onPrimary,
              checkColor: colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppFonts.bodyLarge.copyWith(
                color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
