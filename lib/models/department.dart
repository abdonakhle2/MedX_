import 'package:project_1/models/doctor.dart';

class Department {
  final String? dep_id;
  final String? category;
  final String? description_en;
  final String? description_ar;
  final String? location_ar;
  final String? location_en;
  final double rating;
  final List<Doctor> doctors;

  Department({
    this.dep_id,
    this.category,
    this.description_en,
    this.description_ar,
    this.rating = 0.0,
    this.doctors = const [],
    this.location_ar,
    this.location_en,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    double parsedRating = 0.0;
    if (json['rating'] != null) {
      parsedRating = double.tryParse(json['rating'].toString()) ?? 0.0;
    }

    var parsedDoctors = json['doctors'] ?? json['Doctors'];
    List<Doctor> doctorsList = [];
    if (parsedDoctors is List) {
      doctorsList = parsedDoctors
          .map((doc) => Doctor.fromJson(doc as Map<String, dynamic>))
          .toList();
    }

    // استخراج id و category_id بناءً على استجابة السيرفر
    String departmentId =
        json['id']?.toString() ?? json['dep_id']?.toString() ?? '';
    String categoryValue =
        json['category_id']?.toString() ?? json['category']?.toString() ?? '';

    print(
      'department id = $departmentId, rating = $parsedRating, description_en = ${json['description_en']}, description_ar = ${json['description_ar']}',
    );

    return Department(
      dep_id: departmentId,
      category: categoryValue,
      description_en: json['description_en']?.toString() ?? '',
      description_ar: json['description_ar']?.toString() ?? '',
      location_ar: json['location_ar']?.toString() ?? '',
      location_en: json['location_en']?.toString() ?? '',
      rating: parsedRating,
      doctors: doctorsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dep_id': dep_id,
      'category': category,
      'description_en': description_en,
      'description_ar': description_ar,
      'rating': rating,
      'doctors': doctors.map((doc) => doc.toJson()).toList(),
      'location_ar': location_ar,
      'location_en': location_en,
    };
  }
}
