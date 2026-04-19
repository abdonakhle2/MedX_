import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/models/doctor.dart';
import 'package:flutter/gestures.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class AppointmentScreen extends StatefulWidget {
  final Doctor myDoctor;

  const AppointmentScreen({super.key, required this.myDoctor});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int stepIndex = 1;
  String selectedMethod = "schedule";
  String selectedTime = "02:30 PM";
  int _navIndex = 2;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = ['/home', '/search', '/bookings', '/profile'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  ); // الشهر الذي يتصفحه المستخدم حالياً

  @override
  void initState() {
    super.initState();
    // عند فتح الشاشة، يكون التاريخ المختار هو اليوم
    selectedDate = DateTime(today.year, today.month, today.day);
    // الشهر المعروض يبدأ من الشهر الحالي
    displayedMonth = DateTime(today.year, today.month);
  }

  // دالة مساعدة للحصول على اسم اليوم المختصر
  String _getWeekDayName(DateTime date) {
    List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    return days[date.weekday - 1];
  }

  // دالة مساعدة للحصول على اسم الشهر
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      appBar: AppBar(
        title: Text(
          'MedX',
          style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 50),
            _buildDoctorCard(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Selection Method', style: AppFonts.headlineMedium),
                Text(
                  'Step $stepIndex of 2 ',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildMethodSelection(),
            const SizedBox(height: 25),

            // تظهر خيارات الجدولة فقط عند اختيار "Doctor's Schedule"
            if (selectedMethod == "schedule") _buildSchedulingCard(),

            const SizedBox(height: 50),
            buildAddNote(),
            SizedBox(height: 20),
            buildAppotmentPrice(),
            SizedBox(height: 30),
            buildConfirmButton(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'By confirming, you agree to our ',
                  style: TextStyle(color: AppColors.secondary, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showPolicyDialog(
                            context,

                            "Terms of Service",
                            "1. User must be 18+ years old.\n"
                                "2. Accurate information is required.\n"
                                "3. Cancellations must be 24h prior.",
                          );
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      // عند الضغط على "Privacy Policy"
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showPolicyDialog(
                            context,
                            "Privacy Policy",
                            "• We value your health data privacy.\n"
                                "• Data is encrypted and secured.\n"
                                "• We do not share data with third parties.",
                          );
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void _showPolicyDialog(BuildContext context, String title, String rules) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              rules,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "I Understand",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () {
              _showSuccessDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.neutral,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Confirm Booking",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Icon(Symbols.check_circle, size: 20, color: AppColors.neutral),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ المربع حجم المحتوى فقط
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                'Success!',
                style: AppFonts.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your appointment has been booked successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context), // إغلاق المربع
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Great!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildAppotmentPrice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.greyLight,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Consultation Fee', style: AppFonts.bodyLarge),
              Text(
                '\$${widget.myDoctor.hourly_rate}',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Digital Platform Fee', style: AppFonts.bodyLarge),
              Text(
                '\$${widget.myDoctor.hourly_rate}',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Payable', style: AppFonts.headlineMedium),
              Text(
                '\$${widget.myDoctor.hourly_rate}',
                style: AppFonts.headlineMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddNote() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Symbols.note_alt, color: AppColors.primary),
            Text(' Consultation Notes', style: AppFonts.headlineLarge),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Mention any specific symptoms,medical history,or concerns you wish to discuss during the session',
          style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
        ),
        SizedBox(height: 20),
        TextField(
          cursorColor: AppColors.greyMedium,
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.greyMedium.withOpacity(0.2),
            hintText: 'Type your notes here...',
            hintStyle: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMethodSelection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "earliest"),
          child: _buildOptionCard(
            title: "Earliest Available",
            subtitle: "Today at 4:30 PM",
            icon: Icons.flash_on,
            isActive: selectedMethod == "earliest",
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "schedule"),
          child: _buildOptionCard(
            title: "Doctor's Schedule",
            subtitle: "Pick a custom date/time",
            icon: Icons.calendar_today_outlined,
            isActive: selectedMethod == "schedule",
          ),
        ),
      ],
    );
  }

  Widget _buildSchedulingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          _buildDateSelector(),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          _buildTimeGrid(),
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
              style: AppFonts.headlineSmall,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      displayedMonth = DateTime(
                        displayedMonth.year,
                        displayedMonth.month - 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      displayedMonth = DateTime(
                        displayedMonth.year,
                        displayedMonth.month + 1,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(daysInMonth, (index) {
              DateTime dateItem = DateTime(
                displayedMonth.year,
                displayedMonth.month,
                index + 1,
              );

              // التحقق إذا كان اليوم في الماضي (قبل تاريخ اليوم)
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
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.white70 : AppColors.secondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeGrid() {
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
        childAspectRatio: 2.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: times.length,
      itemBuilder: (context, index) {
        bool isSelected = times[index] == selectedTime;
        return GestureDetector(
          onTap: () => setState(() => selectedTime = times[index]),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey.shade300,
              ),
            ),
            child: Text(
              times[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : AppColors.greyLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isActive ? Colors.white70 : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.greyLight,
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 80, color: AppColors.primary),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.myDoctor.name_en ?? "Doctor Name",
                  style: AppFonts.headlineLarge,
                ),
                Text(
                  widget.myDoctor.specialization ?? "Specialization",
                  style: AppFonts.bodyLarge.copyWith(color: AppColors.primary),
                ),
                Text(
                  '\$${widget.myDoctor.hourly_rate}',
                  style: AppFonts.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SCHEDULING PORTAL',
          style: AppFonts.bodyMedium.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 10),
        Text(
          'Confirm your\nappointment',
          style: AppFonts.headlineExtraLarge.copyWith(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: AppColors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
