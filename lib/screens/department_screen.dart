import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/models/doctor.dart';
import 'package:project_1/screens/appointment_screen.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class DepartmentScreen extends StatefulWidget {
  final String? Category;
  const DepartmentScreen({super.key, this.Category});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  int _navIndex = 0;
  Doctor myDoctor = Doctor(
    id: 1,
    name_en: "Dr. Julian Vane",
    name_ar: "د. جوليان فاين",
    specialization: "Cardiology",
    birthdate: "1980-05-15",
    id_passport: 12345678,
    // هنا نقوم بإنشاء ويدجت Image وتمريره
    photo: Image.asset('assets/images/doctor1.png', fit: BoxFit.cover),
    hourly_rate: 150.0,
    work_hours: "9 AM - 5 PM",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "DEPARTMENT",
            style: AppFonts.bodyMedium.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 10),
          Text(
            "${widget.Category}",
            style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.black),
          ),
          SizedBox(height: 20),
          Text(
            style: AppFonts.bodySmall.copyWith(color: AppColors.secondary),
            'Select a leading specialist from our ${widget.Category} editorial team.Each practitioner is selected for clinical exceliience and an empathetic approach to health.',
          ),
          SizedBox(height: 50),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildDoctorCard(myDoctor);
            },
          ),
        ],
      ),
    );
  }
}

Widget buildDoctorCard(Doctor doctor) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: AppColors.greyLight,
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 15,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Icon(Symbols.psychology_sharp, size: 200),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name_en!,
                style: AppFonts.bodyLarge.copyWith(color: AppColors.black),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    doctor.specialization!,
                    style: AppFonts.bodyLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Text('${doctor.hourly_rate.toString()}\$'),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AppointmentScreen(myDoctor: doctor),
                          ),
                        );
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
                            "Book Appointment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppColors.neutral,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
