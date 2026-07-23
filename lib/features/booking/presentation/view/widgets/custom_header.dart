import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localeText = AppLocalizations.of(context)!;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            gradient: AppGradients.headerGradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              localeText.bookingsRateVisit,
              style: AppFonts.headlineMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Positioned(
          top: 105,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person_rounded,
                size: 55,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
