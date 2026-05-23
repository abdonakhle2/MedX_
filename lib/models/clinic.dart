import 'package:project_1/models/department.dart';

class ClinicModel {
  final String clinic_id;
  final String name_en;
  final String name_ar;
  final String description;
  final String location;
  final int work_hours;
  final String phone_number;
  final String logo;
  final double lat;
  final double log;
  final bool is_24h;
  final List<String> pictures;
  final List<Department> Departments;

  ClinicModel({
    required this.clinic_id,
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
    required this.Departments
  });
  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    var parsedPictures = json['pictures'];
    List<String> picturesList = [];
    if (parsedPictures is List) {
      picturesList = parsedPictures.map((pic) => pic.toString()).toList();
    } else {
      picturesList = [];
    }
    var parsedDepartments=json['Departments']??json['departments'];
    List<Department>departmentsList=[];
    if(parsedDepartments is List){
      departmentsList=parsedDepartments.map((dept)=>Department.fromJson(dept as Map<String,dynamic>)).toList();
    }
    return ClinicModel(
      clinic_id: json['clinic_id'],
      name_en: json['name_en']?.toString() ?? '',
      name_ar: json['name_ar']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      work_hours: int.tryParse(json['work_hours'].toString()) ?? 0,
      phone_number: json['phone_number']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      log: double.tryParse(json['log'].toString()) ?? 0.0,
      is_24h: json['is_24h'] is bool
          ? json['is_24h']
          : json['is_24h']?.toString() == '1' ||
                json['is_24h']?.toString() == 'true',
      pictures: picturesList,
      Departments: departmentsList,
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'clinic_id': clinic_id,
      'name_en': name_en,
      'name_ar': name_ar,
      'description': description,
      'location': location,
      'work_hours': work_hours,
      'phone_number': phone_number,
      'logo':logo,
      'lat': lat,
      'log':log,
      'is_24h':is_24h,
      'pictures':pictures,
      'Departments':Departments.map((dept)=>dept.toJson()).toList(),
    };
  }
}
