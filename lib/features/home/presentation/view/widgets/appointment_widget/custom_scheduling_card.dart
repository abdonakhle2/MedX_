import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/manager/available_time_cubit/appointment_cubit.dart';
import 'package:project_1/features/home/presentation/manager/available_time_cubit/appointment_state.dart';
import 'package:project_1/models/doctor.dart';

class CustomSchedulingCard extends StatefulWidget {
  final Doctor doctor;

  const CustomSchedulingCard({super.key, required this.doctor});

  @override
  State<CustomSchedulingCard> createState() => CustomSchedulingCardState();
}

String _getWeekDayName(DateTime date) {
  List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  return days[date.weekday - 1];
}

String _getMonthName(int month) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  return months[month - 1];
}

class CustomSchedulingCardState extends State<CustomSchedulingCard> {
  DateTime today = DateTime.now();
  DateTime? selectedDate;
  String? selectedHour;
  bool isAsapSelected = true;
  String? earliestAvailableTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(today.year, today.month, today.day);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTimes(selectedDate!);
    });
  }

  // دالة لتصفية الأوقات التي مضت
  List<String> _filterPastTimes(List<String> times) {
    final now = DateTime.now();
    final isToday =
        selectedDate!.year == now.year &&
        selectedDate!.month == now.month &&
        selectedDate!.day == now.day;

    if (!isToday) return times;

    return times.where((timeStr) {
      final parts = timeStr.split(':');
      if (parts.length < 2) return false;
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      final appointmentTime = DateTime(
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );
      return appointmentTime.isAfter(now);
    }).toList();
  }

  String formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  void _fetchTimes(DateTime date) {
    final departmentId = widget.doctor.department_id;
    final doctorId = widget.doctor.doc_id;
    if (doctorId.isEmpty) return;
    context.read<AppointmentCubit>().fetchAvailableTimes(
      departmentId: departmentId,
      doctorId: doctorId,
      date: formatDate(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localeText = AppLocalizations.of(context)!;

    return Column(
      children: [
        // const SizedBox(height: 20),
        // ── Earliest Available Card ──────────────────────
        GestureDetector(
          onTap: () {
            setState(() {
              isAsapSelected = true;
              selectedHour = earliestAvailableTime;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: isDarkMode ? [] : AppShadows.softShadow,
              border: Border.all(
                color: isAsapSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.08),
                width: isAsapSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.flash_on_rounded,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localeText.earliestAvailable,
                        style: AppFonts.bodyLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      BlocBuilder<AppointmentCubit, AppointmentState>(
                        builder: (context, state) {
                          if (state is AppointmentSuccess) {
                            final filtered = _filterPastTimes(
                              state.availableTimes,
                            );
                            if (filtered.isEmpty) {
                              return Text(
                                localeText.noAvailableTimes,
                                style: AppFonts.bodySmall.copyWith(
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              );
                            }
                            final firstTime = filtered.first.substring(0, 5);
                            earliestAvailableTime = firstTime;
                            if (isAsapSelected) selectedHour = firstTime;
                            return Text(
                              '${localeText.todayAt} $firstTime',
                              style: AppFonts.bodySmall.copyWith(
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            );
                          }
                          return Text(
                            '${localeText.loading}...',
                            style: AppFonts.bodySmall.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Icon(
                  isAsapSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // ── Doctor's Schedule Card ───────────────────────
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? today,
              firstDate: today,
              lastDate: today.add(const Duration(days: 90)),
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
                isAsapSelected = false;
                selectedHour = null;
              });
              _fetchTimes(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: !isAsapSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.08),
                width: !isAsapSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localeText.doctorsSchedule,
                        style: AppFonts.bodyLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        selectedDate != null && !isAsapSelected
                            ? '${_getWeekDayName(selectedDate!)}, ${selectedDate!.day} ${_getMonthName(selectedDate!.month)}'
                            : localeText.pickACustomDate,
                        style: AppFonts.bodySmall.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  !isAsapSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        if (!isAsapSelected) ...[
          // const SizedBox(height: 16),
          BlocBuilder<AppointmentCubit, AppointmentState>(
            builder: (context, state) {
              if (state is AppointmentSuccess) {
                final times = _filterPastTimes(state.availableTimes);
                if (times.isEmpty) return Text(localeText.noAvailableTimes);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: times.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                  ),
                  itemBuilder: (context, index) {
                    final hour = times[index].substring(0, 5);
                    return GestureDetector(
                      onTap: () => setState(() => selectedHour = hour),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedHour == hour
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            hour,
                            style: TextStyle(
                              color: selectedHour == hour
                                  ? Colors.white
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ],
    );
  }

  Map<String, dynamic>? getBookingPayload() {
    if (isAsapSelected && earliestAvailableTime != null) {
      return {
        'date': formatDate(today),
        'time': earliestAvailableTime!,
        'is_asap': 1,
      };
    }
    if (selectedDate == null || selectedHour == null) return null;
    return {
      'date': formatDate(selectedDate!),
      'time': selectedHour!,
      'is_asap': 0,
    };
  }
}
