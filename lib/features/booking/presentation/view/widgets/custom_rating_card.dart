import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_comment_box.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_header.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_rating_stars.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_submit_button.dart';

class CustomRatingCard extends StatelessWidget {
  const CustomRatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  "How was your clinical experience with",
                  textAlign: TextAlign.center,
                  style: AppFonts.bodyMedium.copyWith(
                    color: isDarkMode
                        ? colorScheme.onSurface.withOpacity(0.7)
                        : AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Dr. Julian Vane",
                  textAlign: TextAlign.center,
                  style: AppFonts.headlineMedium.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),
                const CustomRatingStars(),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SHARE YOUR THOUGHTS",
                    style: AppFonts.labelSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: isDarkMode
                          ? colorScheme.onSurface.withOpacity(0.6)
                          : AppColors.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const CustomCommentBox(),
                const SizedBox(height: 20),
                const CustomSubmitButton(),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Maybe later",
                    style: AppFonts.bodyMedium.copyWith(
                      color: isDarkMode
                          ? colorScheme.onSurface.withOpacity(0.6)
                          : AppColors.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
