import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomPictureBody extends StatelessWidget {
  const CustomPictureBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              width: size.width * 0.9,
              'assets/images/splashPic.jpg',
              fit: BoxFit.contain,
              // color: colorScheme.onSurface,
            ),
          ),
          // const SizedBox(height: 30),
          Text(
            // 'Your Complete Digital Health Partner',
            localeText.appTitleSplash,
            textAlign: TextAlign.center,
            style: AppFonts.headlineSmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            // 'Professional healthcare services at your fingertips.',
            localeText.appSubtitleSplash,
            textAlign: TextAlign.center,
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.secondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
