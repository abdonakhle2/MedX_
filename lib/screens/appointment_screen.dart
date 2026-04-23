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
  int _navIndex = 0;

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
      backgroundColor: AppColors.greyLight,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'MedX',
              style: AppFonts.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderText(),
            const SizedBox(height: 32),
            _buildDoctorCard(),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selection Method',
                  style: AppFonts.headlineSmall.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Step $stepIndex of 2',
                    style: AppFonts.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildMethodSelection(),
            const SizedBox(height: 25),

            // تظهر خيارات الجدولة فقط عند اختيار "Doctor's Schedule"
            if (selectedMethod == "schedule") _buildSchedulingCard(),

            const SizedBox(height: 40),
            buildAddNote(),
            const SizedBox(height: 24),
            buildAppotmentPrice(),
            const SizedBox(height: 30),
            buildConfirmButton(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'By confirming, you agree to our ',
                  style: AppFonts.bodySmall.copyWith(
                    color: AppColors.secondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary.withOpacity(0.3),
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
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary.withOpacity(0.3),
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
            const SizedBox(height: 100),
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
            borderRadius: BorderRadius.circular(28),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  title.contains("Terms")
                      ? Icons.description_rounded
                      : Icons.shield_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              rules,
              style: AppFonts.bodyMedium.copyWith(
                height: 1.6,
                color: AppColors.secondary,
              ),
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  "I Understand",
                  style: AppFonts.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
      height: 56,
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
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Confirm Booking",
                  style: AppFonts.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
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
            borderRadius: BorderRadius.circular(28),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ المربع حجم المحتوى فقط
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Success!',
                style: AppFonts.headlineLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your appointment has been booked successfully.',
                textAlign: TextAlign.center,
                style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.secondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context), // إغلاق المربع
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Great!',
                    style: AppFonts.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: [
          _buildPriceRow(
            'Consultation Fee',
            '\$${widget.myDoctor.hourly_rate}',
          ),
          const SizedBox(height: 14),
          _buildPriceRow(
            'Digital Platform Fee',
            '\$${widget.myDoctor.hourly_rate}',
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.greyLight,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payable',
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '\$${widget.myDoctor.hourly_rate}',
                style: AppFonts.headlineSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
        ),
        Text(
          price,
          style: AppFonts.bodyLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildAddNote() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Symbols.note_alt, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'Consultation Notes',
              style: AppFonts.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Mention any specific symptoms, medical history, or concerns you wish to discuss during the session.',
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.secondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: TextField(
            cursorColor: AppColors.primary,
            maxLines: 5,
            style: AppFonts.bodyMedium,
            decoration: InputDecoration(
              filled: false,
              hintText: 'Type your notes here...',
              hintStyle: AppFonts.bodyMedium.copyWith(
                color: AppColors.secondary.withOpacity(0.4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(18),
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
            icon: Icons.flash_on_rounded,
            isActive: selectedMethod == "earliest",
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () => setState(() => selectedMethod = "schedule"),
          child: _buildOptionCard(
            title: "Doctor's Schedule",
            subtitle: "Pick a custom date/time",
            icon: Icons.calendar_today_rounded,
            isActive: selectedMethod == "schedule",
          ),
        ),
      ],
    );
  }

  Widget _buildSchedulingCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.softShadow,
      ),
      child: Column(
        children: [
          _buildDateSelector(),
          const SizedBox(height: 20),
          Container(height: 1, color: AppColors.greyLight),
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
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 10),
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

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: isActive ? AppGradients.primaryGradient : null,
        color: isActive ? null : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isActive ? AppShadows.elevatedShadow : AppShadows.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.bodyLarge.copyWith(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppFonts.bodySmall.copyWith(
                    color: isActive
                        ? Colors.white.withOpacity(0.7)
                        : AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? Colors.white.withOpacity(0.5)
                    : AppColors.greyLight,
                width: 2,
              ),
              color: isActive
                  ? Colors.white.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: isActive
                ? Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : const SizedBox(width: 16, height: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: AppShadows.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.12),
                  AppColors.primary.withOpacity(0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.person_rounded,
              size: 44,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.myDoctor.name_en ?? "Doctor Name",
                  style: AppFonts.headlineSmall.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.myDoctor.specialization ?? "Specialization",
                    style: AppFonts.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${widget.myDoctor.hourly_rate}/hr',
                  style: AppFonts.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: AppColors.primary,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'SCHEDULING PORTAL',
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Confirm your\nappointment',
          style: AppFonts.headlineExtraLarge.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
