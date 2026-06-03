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
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  String selectedTime = "02:30 PM";
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
          _buildDateSelector(),
          const SizedBox(height: 0),
          Container(height: 1, color: AppColors.greyLight),
          const SizedBox(height: 0),
          CustomTimeGrid(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    // الحصول على عدد الأيام في الشهر المعروض حالياً
    int daysInMonth = DateUtils.getDaysInMonth(
      displayedMonth.year,
      displayedMonth.month,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_getMonthName(displayedMonth.month)} ${displayedMonth.year}",
              style: AppFonts.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        displayedMonth = DateTime(
                          displayedMonth.year,
                          displayedMonth.month - 1,
                        );
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        displayedMonth = DateTime(
                          displayedMonth.year,
                          displayedMonth.month + 1,
                        );
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(daysInMonth, (index) {
              DateTime dateItem = DateTime(
                displayedMonth.year,
                displayedMonth.month,
                index + 1,
              );

              bool isPast = dateItem.isBefore(
                DateTime(today.year, today.month, today.day),
              );
              bool isSelected =
                  selectedDate.year == dateItem.year &&
                  selectedDate.month == dateItem.month &&
                  selectedDate.day == dateItem.day;

              return Opacity(
                opacity: isPast ? 0.3 : 1.0,
                child: IgnorePointer(
                  ignoring: isPast,
                  child: _buildDateItem(
                    _getWeekDayName(dateItem),
                    (index + 1).toString(),
                    dateItem,
                    isSelected,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDateItem(
    String day,
    String date,
    DateTime fullDate,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = fullDate;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primaryGradient : null,
          color: isSelected ? null : AppColors.greyLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected ? AppShadows.elevatedShadow : [],
        ),
        child: Column(
          children: [
            Text(
              day,
              style: AppFonts.labelSmall.copyWith(
                color: isSelected
                    ? Colors.white.withOpacity(0.7)
                    : AppColors.secondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
              style: AppFonts.headlineSmall.copyWith(
                color: isSelected ? Colors.white : AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomTimeGrid() {
    List<String> times = [
      "09:00 AM",
      "10:00 AM",
      "11:00 AM",
      "12:00 PM",
      "01:00 PM",
      "02:00 PM",
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: times.length,
      itemBuilder: (context, index) {
        bool isSelected = times[index] == selectedTime;
        return GestureDetector(
          onTap: () => setState(() => selectedTime = times[index]),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: isSelected ? AppGradients.primaryGradient : null,
              color: isSelected ? null : AppColors.greyLight,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isSelected ? AppShadows.elevatedShadow : [],
            ),
            child: Text(
              times[index],
              style: AppFonts.labelMedium.copyWith(
                color: isSelected ? Colors.white : AppColors.secondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
