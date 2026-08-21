import 'package:dartz/dartz.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/models/department.dart';
import 'package:project_1/models/doctor.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ClinicModel>>> getClinics();
  Future<Either<Failure, List<Department>>> getClinicDepartments(
    String clinicId,
  );
  Future<Either<Failure, List<Doctor>>> getDoctorsByDepartment(
    String departmentId,
  );
  Future<Either<Failure, List<Doctor>>> getAllDoctors();
  Future<Either<Failure, List<String>>> getDoctorAvailableTimes(
    String departmentId,
    String doctorId,
    String date,
  );
  Future<Either<Failure, Map<String, dynamic>>> bookAppointment({
    required String doctorId,
    required String depId,
    required String date,
    required String time,
    required int isAsap,
    required String userNotes,
  });
  Future<List<Doctor>> getAllDoctorsUsingDepartments({
    required int maxDepartments,
  });
}
