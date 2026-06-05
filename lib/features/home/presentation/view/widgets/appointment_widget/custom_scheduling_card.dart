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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: [
          _buildSelectedDateTimeHeader(context),

          const SizedBox(height: 18),
          Container(height: 1, color: AppColors.greyLight),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildSelectedDateTimeHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment time',
          style: AppFonts.labelLarge.copyWith(
            color: AppColors.secondary,
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
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primary,
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        selectedTime?.format(context) ?? 'No time selected',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.edit_calendar_rounded, color: AppColors.primary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Tap to change date and time',
          style: AppFonts.bodySmall.copyWith(color: AppColors.secondary),
        ),
      ],
    );
  }

  Future<void> _showScheduleDialog(BuildContext context) async {
    DateTime tempDate = selectedDate ?? today;
    TimeOfDay tempTime = selectedTime ?? const TimeOfDay(hour: 14, minute: 30);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: Text(
                'Choose date & time',
                style: AppFonts.headlineSmall.copyWith(
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
                      backgroundColor: AppColors.greyLight,
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
                        const Icon(Icons.calendar_today_rounded),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_getWeekDayName(tempDate)}, ${tempDate.day} ${_getMonthName(tempDate.month)} ${tempDate.year}',
                                style: AppFonts.labelLarge.copyWith(
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
                      backgroundColor: AppColors.greyLight,
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
                        const Icon(Icons.access_time_rounded),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: AppFonts.bodyMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tempTime.format(context),
                                style: AppFonts.labelLarge.copyWith(
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
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: AppFonts.labelLarge.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = tempDate;
                      selectedTime = tempTime;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: AppFonts.labelLarge.copyWith(
                      color: Colors.white,
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
