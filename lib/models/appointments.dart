class Appointments {
  final String appointments_id;
  final DateTime Appointment_time;
  final DateTime Appointment_date;
  final int user_id;
  final int doctor_id;
  final bool is_approved;
  final String Status;
  final String Notes;
  Appointments({
    required this.appointments_id,
    required this.Appointment_time,
    required this.Appointment_date,
    required this.user_id,
    required this.doctor_id,
    required this.is_approved,
    required this.Status,
    required this.Notes,
  });
  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      appointments_id: json['appointments_id'].toString(),
      Appointment_time:
          DateTime.tryParse(json['Appointment_time']?.toString() ?? '') ??
          DateTime.now(),
      Appointment_date:
          DateTime.tryParse(json['Appointment_date']?.toString() ?? '') ??
          DateTime.now(),
      user_id: int.tryParse(json['user_id'].toString()) ?? 0,
      doctor_id: int.tryParse(json['doctor_id'].toString()) ?? 0,
      is_approved: json['is_approved'] is bool
          ? json['is_approved']
          : json['is_approved'].toString() == '1' ||
                json['is_approved'].toString() == 'true',
      Status: json['Status']?.toString() ?? '',
      Notes: json['Notes']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'appointments_id': appointments_id,
      'Appointment_time': Appointment_time.toIso8601String(),
      'Appointment_date': Appointment_date.toIso8601String(),
      'user_id': user_id,
      'doctor_id': doctor_id,
      'is_approved': is_approved,
      'Status': Status,
      'Notes': Notes,
    };
  }
}
