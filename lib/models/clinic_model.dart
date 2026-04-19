import 'package:flutter/material.dart';

class ClinicModel {
  final String name_en;
  final String name_ar;
  final String description;
  final String location;
  final int work_hours;
  final int phone_number;
  final Image logo;
  final double lat;
  final double log;
  final bool is_24h;
  final List<Image> pictures;
  final double rating;

  ClinicModel({
    required this.name_en,
    required this.name_ar,
    required this.description,
    required this.location,
    required this.work_hours,
    required this.phone_number,
    required this.logo,
    required this.lat,
    required this.log,
    required this.is_24h,
    required this.pictures,
    required this.rating,
  });
}
