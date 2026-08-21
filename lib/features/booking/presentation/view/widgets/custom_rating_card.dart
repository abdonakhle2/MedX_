import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/booking/data/booking_repo_imp.dart';
import 'package:project_1/features/booking/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:project_1/features/booking/presentation/manager/rating_cubit/rating_state.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_header.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_rating_stars.dart';
import 'package:project_1/features/booking/presentation/view/widgets/custom_submit_button.dart';
import 'package:project_1/models/appointments.dart';

class CustomRatingCard extends StatefulWidget {
  final Appointments appointment;

  const CustomRatingCard({super.key, required this.appointment});

  @override
  State<CustomRatingCard> createState() => _CustomRatingCardState();
}

class _CustomRatingCardState extends State<CustomRatingCard> {
  double selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final currentLang = Localizations.localeOf(context).languageCode;

    final String doctorName = currentLang == 'ar'
        ? (widget.appointment.doctor?.nameAr ?? 'اسم الطبيب')
        : (widget.appointment.doctor?.nameEn ?? 'Doctor Name');

    return BlocProvider(
      create: (context) => RatingCubit(BookingRepoImpl(Dio())),
      child: BlocConsumer<RatingCubit, RatingState>(
        listener: (context, state) {
          if (state is RatingSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is RatingFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          bool isLoading = state is RatingLoading;

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
                        localeText.ratingQuestion,
                        textAlign: TextAlign.center,
                        style: AppFonts.bodyMedium.copyWith(
                          color: isDarkMode
                              ? colorScheme.onSurface.withOpacity(0.7)
                              : AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctorName,
                        textAlign: TextAlign.center,
                        style: AppFonts.headlineMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomRatingStars(
                        onRatingChanged: (rating) {
                          setState(() {
                            selectedRating = rating;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      CustomSubmitButton(
                        isLoading: isLoading,
                        onPressed: () {
                          if (selectedRating == 0.0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('الرجاء اختيار عدد النجوم أولاً'),
                              ),
                            );
                            return;
                          }
                          context.read<RatingCubit>().submitRating(
                            appointmentId: widget.appointment.id.toString(),
                            rating: selectedRating,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          localeText.ratingMaybeLater,
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
        },
      ),
    );
  }
}
