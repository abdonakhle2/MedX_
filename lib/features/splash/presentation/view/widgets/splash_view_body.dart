import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/cubit/loacale_cubit.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/widgets/custom_button.dart';
import 'package:project_1/features/splash/presentation/view/widgets/custom_language_check_box_item.dart';
import 'package:project_1/features/splash/presentation/view/widgets/custom_picture_body.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentLanguageCode = context.watch<LocaleCubit>().state.languageCode;
    final localeText = AppLocalizations.of(context)!;
    
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: Column(
                children: [
                  // const SizedBox(height: 36),
                  const Expanded(child: Center(child: CustomPictureBody())),

                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF1E293B)
                          : AppColors.greyLight,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeText.selectLanguageLogin,
                          style: AppFonts.bodyLarge.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        LanguageCheckboxItem(
                          title: localeText.englishSplash,
                          selected: currentLanguageCode == 'en',
                          onChanged: (_) =>
                              context.read<LocaleCubit>().changeLanguage('en'),
                        ),
                        const SizedBox(height: 16),
                        LanguageCheckboxItem(
                          title: localeText.arabicSplash,
                          selected: currentLanguageCode == 'ar',
                          onChanged: (_) =>
                              context.read<LocaleCubit>().changeLanguage('ar'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: localeText.continueButtonSplash,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kLogInScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
