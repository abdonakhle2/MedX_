import 'package:flutter/material.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/models/clinic.dart';

class CustomHomeList extends StatelessWidget {
  const CustomHomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        final dummyClinic = ClinicModel(
          clinic_id: 'clinic_$index',
          name_en: 'City General Hospital ${index + 1}',
          name_ar: 'مستشفى المدينة العام ${index + 1}',
          description:
              'A cornerstone of regional health, providing comprehensive emergency care, surgery, and advanced diagnostics.',
          location: '${1.2 + index * 0.3} miles away',
          work_hours: 8,
          phone_number: '123456789',
          logo: '',
          lat: 0.0,
          log: 0.0,
          is_24h: true,
          pictures: [],
          Departments: [],
        );

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 100)),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: CardClinic(clinic: dummyClinic),
        );
      },
    );
  }
}
