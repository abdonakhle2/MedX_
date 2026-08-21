class ClinicModel {
  final int id;
  final String nameEn;
  final String nameAr;

  ClinicModel({required this.id, required this.nameEn, required this.nameAr});

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      nameEn: json['name_en']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
    );
  }
}

class DepartmentModel {
  final int id;
  final String descriptionEn;
  final String descriptionAr;
  final ClinicModel? clinic;

  DepartmentModel({
    required this.id,
    required this.descriptionEn,
    required this.descriptionAr,
    this.clinic,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      descriptionEn: json['description_en']?.toString() ?? '',
      descriptionAr: json['description_ar']?.toString() ?? '',
      clinic: json['clinic'] != null
          ? ClinicModel.fromJson(json['clinic'])
          : null,
    );
  }
}

class DoctorModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final String specializationEn;
  final String specializationAr;

  DoctorModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.specializationEn,
    required this.specializationAr,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      nameEn: json['name_en']?.toString() ?? '',
      nameAr: json['name_ar']?.toString() ?? '',
      specializationEn: json['specialization_en']?.toString() ?? '',
      specializationAr: json['specialization_ar']?.toString() ?? '',
    );
  }
}

class Appointments {
  final String id;
  final int doctorId;
  final int depId;
  final DateTime date;
  final DateTime time;
  final bool isAsap;
  final String userNotes;
  final bool isReturning;
  final double doctorCost;
  final int userId;
  final int clinicId;
  final String status;
  final double appointmentFee;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final String doctorNotes;

  // الحقول التي تربط بيانات السيرفر الحقيقية
  final DoctorModel? doctor;
  final DepartmentModel? department;

  Appointments({
    required this.id,
    required this.doctorId,
    required this.depId,
    required this.date,
    required this.time,
    required this.isAsap,
    required this.userNotes,
    required this.isReturning,
    required this.doctorCost,
    required this.userId,
    required this.clinicId,
    required this.status,
    required this.appointmentFee,
    this.updatedAt,
    this.createdAt,
    required this.doctorNotes,
    this.doctor,
    this.department,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) {
    return Appointments(
      id: json['id']?.toString() ?? '',
      doctorId: int.tryParse(json['doctor_id']?.toString() ?? '') ?? 0,
      depId: int.tryParse(json['dep_id']?.toString() ?? '') ?? 0,
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      time: DateTime.tryParse(json['time']?.toString() ?? '') ?? DateTime.now(),
      isAsap: json['is_asap'] is bool
          ? json['is_asap']
          : json['is_asap'].toString() == '1' ||
                json['is_asap'].toString() == 'true',
      userNotes: json['user_notes']?.toString() ?? '',
      isReturning: json['is_returning'] is bool
          ? json['is_returning']
          : json['is_returning'].toString() == '1' ||
                json['is_returning'].toString() == 'true',
      doctorCost: double.tryParse(json['doctor_cost']?.toString() ?? '') ?? 0.0,
      userId: int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      clinicId: int.tryParse(json['clinic_id']?.toString() ?? '') ?? 0,
      status: json['status']?.toString() ?? '',
      appointmentFee:
          double.tryParse(json['appointment_fee']?.toString() ?? '') ?? 0.0,
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      doctorNotes:
          json['doctor_notes']?.toString() ?? json['notes']?.toString() ?? '',
      // قراءة الكائنات من الـ JSON المرسل من الخادم
      doctor: json['doctor'] != null
          ? DoctorModel.fromJson(json['doctor'])
          : null,
      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
          : null,
    );
  }
}
