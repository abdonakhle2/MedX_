import 'package:project_1/models/appointments.dart';

class Doctor {
  final String doc_id;
  final String name_en;
  final String name_ar;
  final String specialization_en;
  final String specialization_ar;
  final String birthdate;
  final String id_passport;
  final String photo;
  final double fee;
  final double rating; // أضفنا حقل التقييم هنا
  final String department_id;
  final String clinic_id;

  Doctor({
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.specialization_en,
    required this.specialization_ar,
    required this.birthdate,
    required this.id_passport,
    required this.photo,
    required this.fee,
    this.rating = 0.0,
    this.department_id = '',
    this.clinic_id = '',
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    var parsedAppointments = json['Appointments'] ?? json['appointments'];
    List<Appointments> appointmentsList = [];
    if (parsedAppointments is List) {
      appointmentsList = parsedAppointments
          .map((app) => Appointments.fromJson(app as Map<String, dynamic>))
          .toList();
    }

    String extractedDepId = '';
    String extractedClinicId = '';
    double extractedFee = 0.0;

    double parsedRating = 0.0;
    if (json['rating'] != null) {
      parsedRating = double.tryParse(json['rating'].toString()) ?? 0.0;
    }

    if (json['departments'] is List &&
        (json['departments'] as List).isNotEmpty) {
      var firstDept = json['departments'][0];
      if (firstDept is Map) {
        extractedDepId = firstDept['id']?.toString() ?? '';
        extractedClinicId = firstDept['clinic_id']?.toString() ?? '';

        var pivotData = firstDept['pivot'];
        if (pivotData is Map) {
          if (extractedDepId.isEmpty) {
            extractedDepId = pivotData['department_id']?.toString() ?? '';
          }
          if (extractedClinicId.isEmpty) {
            extractedClinicId = pivotData['clinic_id']?.toString() ?? '';
          }
          extractedFee =
              double.tryParse(pivotData['hourly_rate']?.toString() ?? '') ??
              0.0;
        }
      }
    }

    if (extractedDepId.isEmpty) {
      extractedDepId =
          json['department_id']?.toString() ?? json['dep_id']?.toString() ?? '';
    }

    if (extractedClinicId.isEmpty) {
      extractedClinicId = json['clinic_id']?.toString() ?? '';
    }

    if (extractedFee == 0.0) {
      extractedFee =
          double.tryParse(
            json['fee']?.toString() ?? json['hourly_rate']?.toString() ?? '0.0',
          ) ??
          0.0;
    }

    String doctorId =
        json['doc_id']?.toString() ??
        json['doctor_id']?.toString() ??
        json['id']?.toString() ??
        '';

    print(
      'doctor id = $doctorId, rating = $parsedRating, dep id = $extractedDepId, clinic id = $extractedClinicId, fee = $extractedFee',
    );

    return Doctor(
      doc_id: doctorId,
      name_en: json['name_en']?.toString() ?? '',
      name_ar: json['name_ar']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      id_passport: json['id_passport']?.toString() ?? '',
      photo: json['photo']?.toString() ?? '',
      fee: extractedFee,
      rating: parsedRating,
      department_id: extractedDepId,
      clinic_id: extractedClinicId,
      specialization_en:
          json['specialization_en']?.toString() ??
          json['specialization']?.toString() ??
          '',
      specialization_ar:
          json['specialization_ar']?.toString() ??
          json['specialization']?.toString() ??
          '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_id': doc_id,
      'specialization_en': specialization_en,
      'specialization_ar': specialization_ar,
      'name_en': name_en,
      'name_ar': name_ar,
      'birthdate': birthdate,
      'photo': photo,
      'fee': fee,
      'rating': rating,
      'department_id': department_id,
      'clinic_id': clinic_id,
    };
  }
}
