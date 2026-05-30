import 'package:flutter/material.dart';
import 'package:project_1/models/doctor.dart';
import 'package:project_1/widgets/doctor_card.dart';

class CustomDoctorGridView extends StatelessWidget {
  const CustomDoctorGridView({super.key});

  Doctor get _sampleDoctor => Doctor(
    doc_id: '1',
    name_en: 'Dr. Julian Vane',
    name_ar: 'د. جوليان فاين',
    specialization: 'Cardiology',
    birthdate: '1980-05-15',
    id_passport: '12345678',
    photo: '',
    hourly_rate: 150.0,
    work_hours: '9 AM - 5 PM',
    appointments: const [],
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisExtent: 300,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        return buildDoctorCard(_sampleDoctor, isGridView: true);
      },
    );
  }
}
