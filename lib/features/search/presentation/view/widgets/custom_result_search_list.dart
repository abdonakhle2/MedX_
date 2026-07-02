import 'package:flutter/material.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/core/widgets/doctor_card.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/models/doctor.dart';

class CustomResultSearchList extends StatelessWidget {
  const CustomResultSearchList({super.key, required this.isCenter});
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    return isCenter
        ? ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              final dummyClinic = ClinicModel(
                clinic_id: 'search_clinic_$index',
                name_en: 'Search Clinic Center ${index + 1}',
                name_ar: 'مركز عيادات البحث ${index + 1}',
                description:
                    'A cornerstone of regional health, providing comprehensive emergency care, surgery, and advanced diagnostics.',
                location: '${0.5 + index * 0.4} miles away',
                work_hours: 8,
                phone_number: '987654321',
                logo: '',
                lat: 0.0,
                log: 0.0,
                is_24h: false,
                pictures: [],
                Departments: [],
              );

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 15 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: isCenter
                    ? CardClinic(clinic: dummyClinic)
                    : buildDoctorCard(
                        context,
                        Doctor(
                          doc_id: '1',
                          name_en: 'ali ahmad',
                          name_ar: 'علي احمد',
                          birthdate: '2/3/2000',
                          id_passport: '12',
                          photo: '',
                          hourly_rate: 12,
                          work_hours: '4',
                          specialization: 'cardiology',
                          appointments: [],
                        ),
                      ),
              );
            },
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              return TweenAnimationBuilder<double>(
                key: ValueKey('doctor_$index'),
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 15 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: buildDoctorCard(
                  context,
                  Doctor(
                    doc_id: '1',
                    name_en: 'ali ahmad',
                    name_ar: 'علي احمد',
                    birthdate: '2/3/2000',
                    id_passport: '12',
                    photo: '',
                    hourly_rate: 12,
                    work_hours: '4',
                    specialization: 'cardiology',
                    appointments: [],
                  ),
                  isGridView: true,
                ),
              );
            },
          );
  }
}
