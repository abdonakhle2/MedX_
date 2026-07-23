import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';

class CustomCommentBox extends StatelessWidget {
  const CustomCommentBox({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(18),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        maxLines: 5,
        style: AppFonts.bodyMedium,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: localeText.ratingCommentHint,
          hintStyle: AppFonts.bodySmall.copyWith(
            color: AppColors.secondary.withOpacity(0.5),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
