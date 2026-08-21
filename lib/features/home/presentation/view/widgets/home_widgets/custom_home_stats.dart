import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_divider.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_state_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';

class CustomHomeStats extends StatelessWidget {
  const CustomHomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final clinics = homeCubit.clinics;
        final centersCount = clinics.length;

        // حساب متوسط التقييم للمراكز إن وجدت
        double avgRating = 0.0;
        if (centersCount > 0) {
          double totalRating = 0.0;
          for (var clinic in clinics) {
            totalRating += clinic.rating;
          }
          avgRating = totalRating / centersCount;
        }

        final displayCenters = centersCount > 0 ? '$centersCount+' : '0';
        final displayAvgRating = centersCount > 0
            ? avgRating.toStringAsFixed(1)
            : '0.0';

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? AppGradients.primaryDarkGradient
                : AppGradients.headerGradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isDarkMode ? [] : AppShadows.elevatedShadow,
          ),
          child: Column(
            children: [
              Text(
                localeText.homeOurNetwork,
                style: AppFonts.labelSmall.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.6 : 0.7),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              // صف واحد يعرض عدد المراكز ومتوسط التقييم فقط
              Row(
                children: [
                  CustomStateItem(
                    value: displayCenters,
                    label: localeText.homeCentersCount,
                    icon: Icons.location_city_rounded,
                  ),
                  const CustomDivider(),
                  CustomStateItem(
                    value: displayAvgRating,
                    label: localeText.homeAvgRating,
                    icon: Icons.star_rounded,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
