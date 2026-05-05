class Appointments {
  final int appointments_id;
  final DateTime Appointment_time;
  final DateTime Appointment_date;
  final int user_id;
  final int doctor_id;
  bool is_approved;
  Appointments({
    required this.appointments_id,
    required this.Appointment_time,
    required this.Appointment_date,
    required this.user_id,
    required this.doctor_id,
    required this.is_approved,
  });
}
