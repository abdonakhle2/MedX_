import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';

import 'package:project_1/models/doctor.dart';

class CustomTopRatedDoctors extends StatelessWidget {
  const CustomTopRatedDoctors({super.key});

  static final topDoctors = [
    Doctor(
      doc_id: '1',
      name_en: 'Dr. Ayman Khalid',
      name_ar: 'د. أيمن خالد',
      birthdate: '1985-06-12',
      id_passport: 'A1234567',
      photo:
          'https://images.unsplash.com/photo-1550831107-1553da8c8464?auto=format&fit=crop&w=500&q=60',
      hourly_rate: 125.0,
      work_hours: '9:00 - 17:00',
      specialization: 'Cardiologist',
      appointments: const [],
    ),
    Doctor(
      doc_id: '2',
      name_en: 'Dr. Sara Amin',
      name_ar: 'د. سارة أمين',
      birthdate: '1988-03-02',
      id_passport: 'B2345678',
      photo:
          'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=500&q=60',
      hourly_rate: 140.0,
      work_hours: '10:00 - 18:00',
      specialization: 'Dermatologist',
      appointments: const [],
    ),
    Doctor(
      doc_id: '3',
      name_en: 'Dr. Omar Adel',
      name_ar: 'د. عمر عادل',
      birthdate: '1982-11-18',
      id_passport: 'C3456789',
      photo:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=500&q=60',
      hourly_rate: 118.0,
      work_hours: '8:00 - 16:00',
      specialization: 'Orthopedic',
      appointments: const [],
    ),
    Doctor(
      doc_id: '4',
      name_en: 'Dr. Lina Farouk',
      name_ar: 'د. لينا فاروق',
      birthdate: '1990-09-05',
      id_passport: 'D4567890',
      photo:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=500&q=60',
      hourly_rate: 132.0,
      work_hours: '11:00 - 19:00',
      specialization: 'Pediatrician',
      appointments: const [],
    ),
  ];

  static const ratings = [4.9, 4.8, 4.8, 5.0];

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            localeText.homeTopRatedDoctors,
            style: AppFonts.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: topDoctors.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final doctor = topDoctors[index];
              final rating = ratings[index];

              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AppointmentScreen(myDoctor: doctor),
                  //   ),
                  // );
                  GoRouter.of(
                    context,
                  ).push(AppRouter.kAppointmentScreen, extra: doctor);
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppShadows.cardShadow,
                    image: DecorationImage(
                      image: NetworkImage(doctor.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.08),
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.20),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow:
                                Theme.of(context).brightness == Brightness.dark
                                ? []
                                : AppShadows.softShadow,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toStringAsFixed(1),
                                style: AppFonts.labelSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.name_en,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.labelLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              doctor.specialization,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'clinicName',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
