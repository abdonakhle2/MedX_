import 'package:project_1/models/appointments.dart';

class Doctor {
  final String doc_id;
  final String specialization;
  final String name_en;
  final String name_ar;
  final String birthdate;
  final String id_passport;
  final String photo;
  final double hourly_rate;
  final String work_hours;
  final List<Appointments> appointments;
  Doctor({
    required this.doc_id,
    required this.name_en,
    required this.name_ar,
    required this.birthdate,
    required this.id_passport,
    required this.photo,
    required this.hourly_rate,
    required this.work_hours,
    required this.specialization,
    required this.appointments,
  });
  factory Doctor.fromJson(Map<String, dynamic> json) {
    var parsedAppointments = json['Appointments'] ?? json['appointments'];
    List<Appointments> appointmentsList = [];
    if (parsedAppointments is List) {
      appointmentsList = parsedAppointments
          .map((app) => Appointments.fromJson(app as Map<String, dynamic>))
          .toList();
    }
    return Doctor(
      doc_id: json['doc_id']?.toString() ?? '',
      name_en: json['name_en']?.toString() ?? '',
      name_ar: json['name_ar']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      id_passport: json['id_passport']?.toString() ?? '',
      photo: json['photo']?.toString() ?? '',
      hourly_rate: double.tryParse(json['hourly_rate'].toString()) ?? 0.0,
      work_hours: json['work_hours']?.toString() ?? '',
      specialization: json['specialization']?.toString() ?? '',
      appointments: appointmentsList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'doc_id': doc_id,
      'specialization': specialization,
      'name_en': name_en,
      'name_ar': name_ar,
      'birthdate': birthdate,
      'photo': photo,
      'hourly_rate': hourly_rate,
      'work_hours': work_hours,
      'Appointments': appointments.map((app) => app.toJson()).toList(),
    };
  }
}
