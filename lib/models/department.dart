import 'package:project_1/models/doctor.dart';
import 'package:project_1/models/reviews.dart';

class Department {
  final String? dep_id;
  final String? category;
  final List<Reviews> reviews;
  final List<Doctor> doctors;

  Department({
    this.dep_id,
    this.category,
    this.reviews = const [],
    this.doctors = const [],
  });
  factory Department.fromJson(Map<String, dynamic> json) {
    var parsedReviews = json['reviews'] ?? json['Reviews'];
    List<Reviews> reviewsList = [];
    if (parsedReviews is List) {
      reviewsList = parsedReviews
          .map((rev) => Reviews.fromJson(rev as Map<String, dynamic>))
          .toList();
    }
    var parsedDoctors = json['doctors'] ?? json['Doctors'];
    List<Doctor> doctorsList = [];
    if (parsedDoctors is List) {
      doctorsList = parsedDoctors
          .map((doc) => Doctor.fromJson(doc as Map<String, dynamic>))
          .toList();
    }
    return Department(
      dep_id: json['dep_id']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      reviews: reviewsList,
      doctors: doctorsList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dep_id': dep_id,
      'category': category,
      'reviews': reviews.map((rev) => rev.toJson()).toList(),
      'doctors': doctors.map((doc) => doc.toJson()).toList(),
    };
  }
}
