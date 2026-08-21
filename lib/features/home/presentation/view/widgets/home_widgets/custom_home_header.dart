import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appointment_state.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocBuilder<UserAppointmentsCubit, UserAppointmentsState>(
      builder: (context, state) {
        Widget content = const SizedBox.shrink();

        if (state is UserAppointmentsSuccess) {
          // 1. فلترة الحجوزات التي حالتها booked فقط
          final bookedAppointments = state.appointments.where((a) {
            return a.status.toLowerCase() == 'booked';
          }).toList();

          // 2. ترتيب الحجوزات تصاعدياً حسب الأسبق
          bookedAppointments.sort((a, b) {
            int dateComparison = a.date.compareTo(b.date);
            if (dateComparison != 0) {
              return dateComparison;
            }
            return a.time.compareTo(b.time);
          });

          // 3. عرض الحجز الأول (الأسبق تماماً)
          if (bookedAppointments.isNotEmpty) {
            content = GestureDetector(
              onTap: () {
                context.push(AppRouter.kBookingScreen);
              },
              child: _buildAppointmentContainer(
                context,
                bookedAppointments.first,
                isDarkMode,
              ),
            );
          } else {
            content = _buildDefaultContainer(context, localeText, isDarkMode);
          }
        } else if (state is UserAppointmentsLoading) {
          content = const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          content = _buildDefaultContainer(context, localeText, isDarkMode);
        }

        return SliverToBoxAdapter(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: content,
          ),
        );
      },
    );
  }

  // واجهة عرض الموعد الأسبق
  Widget _buildAppointmentContainer(
    BuildContext context,
    dynamic appointment,
    bool isDarkMode,
  ) {
    final localeText = AppLocalizations.of(context)!;
    String displayDate =
        "${appointment.date.year}-${appointment.date.month.toString().padLeft(2, '0')}-${appointment.date.day.toString().padLeft(2, '0')}";

    String displayTime =
        "${appointment.time.hour.toString().padLeft(2, '0')}:${appointment.time.minute.toString().padLeft(2, '0')}";

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? AppGradients.primaryDarkGradient
            : AppGradients.headerGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isDarkMode ? [] : AppShadows.elevatedShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.04 : 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${localeText.homeUpcomingAppointment} :",
                    style: AppFonts.bodyMedium.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withOpacity(0.85),
                      height: 1.5,
                    ),
                  ),
                  // 🟢 أيقونة الإشعارات هنا
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 22,
                    ),
                    onPressed: () {
                      context.push(AppRouter.kNotificationsScreen);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? (appointment.doctor?.nameAr ?? "طبيب")
                    : (appointment.doctor?.nameEn ?? "Doctor"),
                style: AppFonts.headlineLarge.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  height: 1.2,
                  fontSize: 22,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            displayDate,
                            style: AppFonts.bodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            displayTime,
                            style: AppFonts.bodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // واجهة العرض الافتراضية
  Widget _buildDefaultContainer(
    BuildContext context,
    AppLocalizations localeText,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? AppGradients.primaryDarkGradient
            : AppGradients.headerGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isDarkMode ? [] : AppShadows.elevatedShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary.withOpacity(isDarkMode ? 0.04 : 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      localeText.homeHeaderTitle,
                      style: AppFonts.headlineLarge.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                  // 🟢 أيقونة الإشعارات في الواجهة الافتراضية أيضاً
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 22,
                    ),
                    onPressed: () {
                      context.push(AppRouter.kNotificationsScreen);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                localeText.homeHeaderSubtitle,
                style: AppFonts.bodyMedium.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.85),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    GoRouter.of(context).push(AppRouter.kSearchScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? const Color(0xFF1E293B)
                      : Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: isDarkMode
                      ? themeColor(context)
                      : AppColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localeText.homeBookAppointment,
                      style: AppFonts.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.onSurface
                            : AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color themeColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary;
}
