import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomSchedulingCard extends StatefulWidget {
  const CustomSchedulingCard({super.key});

  @override
  State<CustomSchedulingCard> createState() => _CustomSchedulingCardState();
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

class _CustomSchedulingCardState extends State<CustomSchedulingCard> {
  DateTime today = DateTime.now();
  DateTime? selectedDate;
  DateTime displayedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(today.year, today.month, today.day);
    displayedMonth = DateTime(today.year, today.month);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isDarkMode ? [] : AppShadows.softShadow,
            border: Border.all(
              color: colorScheme.onSurface.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildSelectedDateTimeHeader(context),
              const SizedBox(height: 18),
              Container(
                height: 1,
                color: colorScheme.onSurface.withOpacity(0.1),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedDateTimeHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment time',
          style: AppFonts.labelLarge.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showScheduleDialog(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.05),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.onSurface.withOpacity(0.05),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
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
                        selectedDate != null
                            ? '${_getWeekDayName(selectedDate!)}, ${selectedDate!.day} ${_getMonthName(selectedDate!.month)} ${selectedDate!.year}'
                            : 'No date selected',
                        style: AppFonts.bodyLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        selectedTime?.format(context) ?? 'No time selected',
                        style: AppFonts.bodyMedium.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.edit_calendar_rounded, color: colorScheme.primary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tap to change date and time',
          style: AppFonts.bodySmall.copyWith(
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Future<void> _showScheduleDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    DateTime tempDate = selectedDate ?? today;
    TimeOfDay tempTime = selectedTime ?? const TimeOfDay(hour: 14, minute: 30);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: Text(
                'Choose date & time',
                style: AppFonts.headlineSmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      backgroundColor: colorScheme.onSurface.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: tempDate,
                        firstDate: today,
                        lastDate: today.add(const Duration(days: 90)),
                        helpText: 'Select appointment date',
                      );
                      if (date != null) {
                        dialogSetState(() {
                          tempDate = date;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_getWeekDayName(tempDate)}, ${tempDate.day} ${_getMonthName(tempDate.month)} ${tempDate.year}',
                                style: AppFonts.labelLarge.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      backgroundColor: colorScheme.onSurface.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: tempTime,
                      );
                      if (time != null) {
                        dialogSetState(() {
                          tempTime = time;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tempTime.format(context),
                                style: AppFonts.labelLarge.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = tempDate;
                      selectedTime = tempTime;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: AppFonts.labelLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
