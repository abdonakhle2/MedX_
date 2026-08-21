import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class BookingStatusToggle extends StatelessWidget {
  final bool isPending;
  final ValueChanged<bool> onChanged;

  const BookingStatusToggle({
    super.key,
    required this.isPending,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDarkMode
            ? colorScheme.surface
            : colorScheme.onSurface.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(isDarkMode ? 0.1 : 0.05),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged(true);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: isPending ? AppGradients.primaryGradient : null,
                  color: isPending ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    localeText.bookingsPending,
                    style: AppFonts.labelLarge.copyWith(
                      color: isPending
                          ? Colors.white
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onChanged(false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: !isPending ? AppGradients.primaryGradient : null,
                  color: !isPending ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    localeText.bookingsCompleted,
                    style: AppFonts.labelLarge.copyWith(
                      color: !isPending
                          ? Colors.white
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
