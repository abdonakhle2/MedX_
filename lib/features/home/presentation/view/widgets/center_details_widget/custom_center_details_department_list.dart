import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_department_card.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/widgets/doctor_card.dart';
import 'package:project_1/models/doctor.dart';

class CustomCenterDetailsDepartmentList extends StatefulWidget {
  const CustomCenterDetailsDepartmentList({super.key});

  @override
  State<CustomCenterDetailsDepartmentList> createState() =>
      _CustomCenterDetailsDepartmentListState();
}

class _CustomCenterDetailsDepartmentListState
    extends State<CustomCenterDetailsDepartmentList> {
  int selectedIndex = 0;

  // sample departments with Doctor models (replace with real data later)
  late final List<Map<String, dynamic>> departments;

  @override
  void initState() {
    super.initState();
    departments = List.generate(5, (i) {
      final doctors = List.generate(6 + (i % 3), (j) {
        return Doctor(
          doc_id: '${i}_$j',
          name_en:
              'Dr. ${['Ayman', 'Sara', 'Omar', 'Lina', 'Nour', 'Khaled'][j % 6]} ${j + 1}',
          name_ar: '',
          birthdate: '1980-01-01',
          id_passport: '000${i}${j}',
          photo: '',
          hourly_rate: 45.0 + j,
          work_hours: '9:00 - 17:00',
          specialization: 'Specialty ${i + 1}',
          appointments: [],
        );
      });
      return {
        'title': 'Department ${i + 1}',
        'description': 'Specialized care and services',
        'icon': Symbols.dentistry,
        'doctors': doctors,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width < 600 ? 2 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: departments.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final dep = departments[index];
                return CustomDepartmentCard(
                  icon: dep['icon'],
                  title: dep['title'],
                  description: dep['description'],
                  isSelected: index == selectedIndex,
                  onTap: () => setState(() => selectedIndex = index),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Doctors',
            style: AppFonts.headlineSmall.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            itemCount:
                (departments[selectedIndex]['doctors'] as List<Doctor>).length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, idx) {
              final doc =
                  (departments[selectedIndex]['doctors'] as List<Doctor>)[idx];
              return buildDoctorCard(doc, isGridView: true);
            },
          ),
        ),
      ],
    );
  }
}
