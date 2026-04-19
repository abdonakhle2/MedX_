import 'package:flutter/material.dart';

class Doctor {
  int? id;
  String? specialization;
  String? name_en;
  String? name_ar;
  String? birthdate;
  int? id_passport;
  Image? photo;
  double? hourly_rate;
  String? work_hours;
  Doctor({
    required this.id,
    required this.name_en,
    required this.name_ar,
    required this.birthdate,
    required this.id_passport,
    required this.photo,
    required this.hourly_rate,
    required this.work_hours,
    required this.specialization,
  });
}
