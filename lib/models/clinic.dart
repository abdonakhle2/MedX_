import 'package:project_1/models/department.dart';

class ClinicModel {
  final String clinic_id;
  final String name_en;
  final String name_ar;
  final String description_en;
  final String description_ar;
  final String location_en;
  final String location_ar;
  final String phone_number;
  final String logo;
  final double lat;
  final double log;
  final bool is_24h;
  final String start_time;
  final String end_time;
  final double rating;
  final List<String> pictures;
  final List<Department> Departments;

  ClinicModel({
    required this.clinic_id,
    required this.name_en,
    required this.name_ar,
    required this.description_en,
    required this.description_ar,
    required this.location_en,
    required this.location_ar,
    required this.phone_number,
    required this.logo,
    required this.lat,
    required this.log,
    required this.is_24h,
    required this.start_time,
    required this.end_time,
    this.rating = 0.0,
    required this.pictures,
    required this.Departments,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    var parsedPictures = json['pictures'];
    List<String> picturesList = [];
    if (parsedPictures is List) {
      picturesList = parsedPictures.map((pic) => pic.toString()).toList();
    } else {
      picturesList = [];
    }

    var parsedDepartments = json['Departments'] ?? json['departments'];
    List<Department> departmentsList = [];
    if (parsedDepartments is List) {
      departmentsList = parsedDepartments
          .map((dept) => Department.fromJson(dept as Map<String, dynamic>))
          .toList();
    }

    double parsedRating = 0.0;
    if (json['rating'] != null) {
      parsedRating = double.tryParse(json['rating'].toString()) ?? 0.0;
    }

    return ClinicModel(
      clinic_id: json['id']?.toString() ?? json['clinic_id']?.toString() ?? '',
      name_en: json['name_en']?.toString() ?? '',
      name_ar: json['name_ar']?.toString() ?? '',
      description_en:
          json['description_en']?.toString() ??
          json['description']?.toString() ??
          '',
      description_ar: json['description_ar']?.toString() ?? '',
      location_en:
          json['location_en']?.toString() ?? json['location']?.toString() ?? '',
      location_ar: json['location_ar']?.toString() ?? '',
      phone_number: json['phone_number']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      rating: parsedRating,
      lat:
          double.tryParse(
            json['latitude']?.toString() ?? json['lat']?.toString() ?? '0.0',
          ) ??
          0.0,
      log:
          double.tryParse(
            json['longitude']?.toString() ?? json['log']?.toString() ?? '0.0',
          ) ??
          0.0,
      is_24h: () {
        bool calculatedIs24h = json['is_24h'] is bool
            ? json['is_24h']
            : json['is_24h']?.toString() == '1' ||
                  json['is_24h']?.toString() == 'true';

        String start = json['start_time']?.toString() ?? '';
        String end = json['end_time']?.toString() ?? '';

        if (!calculatedIs24h && start.isNotEmpty && end.isNotEmpty) {
          try {
            int startH = int.parse(start.split(':')[0]);
            int endH = int.parse(end.split(':')[0]);
            int diff = endH - startH;
            if (diff <= 0) diff += 24;
            if (diff == 24) calculatedIs24h = true;
          } catch (_) {}
        }
        return calculatedIs24h;
      }(),
      start_time: json['start_time']?.toString() ?? '',
      end_time: json['end_time']?.toString() ?? '',
      pictures: picturesList,
      Departments: departmentsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinic_id': clinic_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'description_en': description_en,
      'description_ar': description_ar,
      'location_en': location_en,
      'location_ar': location_ar,
      'phone_number': phone_number,
      'logo': logo,
      'rating': rating,
      'lat': lat,
      'log': log,
      'is_24h': is_24h,
      'start_time': start_time,
      'end_time': end_time,
      'pictures': pictures,
      'Departments': Departments.map((dept) => dept.toJson()).toList(),
    };
  }
}
