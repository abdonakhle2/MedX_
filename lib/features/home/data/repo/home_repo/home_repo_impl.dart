import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/models/department.dart';
import 'package:project_1/models/doctor.dart';

class HomeRepoImpl implements HomeRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  HomeRepoImpl(this.dio, {this.secureStorage = const FlutterSecureStorage()});

  @override
  Future<Either<Failure, List<ClinicModel>>> getClinics() async {
    try {
      var response = await dio.get('https://medx.sy/api/clinics/management/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ClinicModel> clinics = [];
        var responseData = response.data;
        List dataList = [];

        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          if (responseData['data'] is List) {
            dataList = responseData['data'];
          } else if (responseData['data'] is Map &&
              responseData['data']['data'] is List) {
            dataList = responseData['data']['data'];
          } else {
            dataList = [responseData];
          }
        }

        for (var item in dataList) {
          clinics.add(ClinicModel.fromJson(item));
        }
        return Right(clinics);
      } else {
        return Left(ServerFailure('Failed to fetch clinics.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Department>>> getClinicDepartments(
    String clinicId,
  ) async {
    try {
      var response = await dio.get(
        'https://medx.sy/api/clinics/departments/$clinicId',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Department> departments = [];
        var responseData = response.data;
        List dataList = [];

        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          if (responseData['data'] is List) {
            dataList = responseData['data'];
          } else if (responseData['data'] is Map &&
              responseData['data']['data'] is List) {
            dataList = responseData['data']['data'];
          } else {
            dataList = [responseData];
          }
        }

        for (var item in dataList) {
          departments.add(Department.fromJson(item));
        }
        return Right(departments);
      } else {
        return Left(ServerFailure('Failed to fetch departments.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getDoctorsByDepartment(
    String departmentId,
  ) async {
    try {
      var response = await dio.get(
        'https://medx.sy/api/clinics/doctors/department/$departmentId',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Doctor> doctors = [];
        var responseData = response.data;
        List dataList = [];

        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          if (responseData['data'] is List) {
            dataList = responseData['data'];
          } else if (responseData['data'] is Map &&
              responseData['data']['data'] is List) {
            dataList = responseData['data']['data'];
          } else {
            dataList = [responseData];
          }
        }

        for (var item in dataList) {
          // نمرر الـ Map مباشرة حتى يقرأ Doctor.fromJson مصفوفة الـ departments والـ pivot بحرية
          doctors.add(Doctor.fromJson(item as Map<String, dynamic>));
        }
        return Right(doctors);
      } else {
        return Left(ServerFailure('Failed to fetch doctors.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getAllDoctors() async {
    try {
      var response = await dio.get('https://medx.sy/api/clinics/doctors/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Doctor> doctors = [];
        var responseData = response.data;
        List dataList = [];

        if (responseData is List) {
          dataList = responseData;
        } else if (responseData is Map) {
          if (responseData['data'] is List) {
            dataList = responseData['data'];
          } else if (responseData['data'] is Map &&
              responseData['data']['data'] is List) {
            dataList = responseData['data']['data'];
          } else {
            dataList = [responseData];
          }
        }

        for (var item in dataList) {
          doctors.add(Doctor.fromJson(item));
        }
        return Right(doctors);
      } else {
        return Left(ServerFailure('Failed to fetch all doctors.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getDoctorAvailableTimes(
    String departmentId,
    String doctorId,
    String date,
  ) async {
    try {
      var response = await dio.get(
        'https://medx.sy/api/departments/$departmentId/available?date=$date',
      );
      print('=== API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;
        if (responseData['success'] == true && responseData['data'] != null) {
          var doctorsList = responseData['data']['doctors'];
          if (doctorsList is List) {
            for (var docData in doctorsList) {
              if (docData['doctor_id'].toString() == doctorId) {
                var availableTimes = docData['available_times'];
                if (availableTimes is List) {
                  return Right(
                    availableTimes.map((e) => e.toString()).toList(),
                  );
                }
              }
            }
          }
        }
        return const Right([]);
      } else {
        return Left(ServerFailure('Failed to fetch available times.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Searches across departments 1..maxDept to find the doctor's available times.
  /// Used when department_id is unknown on the Doctor object.
  Future<Either<Failure, List<String>>> findDoctorAvailableTimes(
    String doctorId,
    String date, {
    int maxDept = 20,
  }) async {
    try {
      for (int depId = 1; depId <= maxDept; depId++) {
        try {
          var response = await dio.get(
            'https://medx.sy/api/departments/$depId/available?date=$date',
          );
          if ((response.statusCode == 200 || response.statusCode == 201) &&
              response.data['success'] == true) {
            var doctorsList = response.data['data']?['doctors'];
            if (doctorsList is List) {
              for (var docData in doctorsList) {
                if (docData['doctor_id'].toString() == doctorId) {
                  var availableTimes = docData['available_times'];
                  if (availableTimes is List && availableTimes.isNotEmpty) {
                    return Right(
                      availableTimes.map((e) => e.toString()).toList(),
                    );
                  }
                }
              }
            }
          }
        } catch (_) {
          // ignore errors for individual departments and continue
        }
      }
      return const Right([]);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> bookAppointment({
    required String doctorId,
    required String depId,
    required String date,
    required String time,
    required int isAsap,
    required String userNotes,
  }) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('No auth token found. Please login again.'));
      }

      final Map<String, dynamic> data = {
        'doctor_id': doctorId,
        'dep_id': depId,
        'date': date,
        'time': time,
        'is_asap': isAsap,
        'user_notes': userNotes,
      };

      FormData formData = FormData.fromMap(data);

      final response = await dio.post(
        'https://medx.sy/api/appointments',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          return Right(responseData);
        } else if (responseData is Map) {
          return Right(Map<String, dynamic>.from(responseData));
        } else {
          return Right({'data': responseData});
        }
      } else {
        return Left(ServerFailure('Failed to book appointment.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<List<Doctor>> getAllDoctorsUsingDepartments({
    required int maxDepartments,
  }) async {
    List<Doctor> allCombinedDoctors = [];
    for (int depId = 1; depId <= maxDepartments; depId++) {
      var result = await getDoctorsByDepartment(depId.toString());
      result.fold((failure) {}, (doctors) {
        for (var doc in doctors) {
          // التحقق من وجود الطبيب لمنع التكرار
          if (!allCombinedDoctors.any((d) => d.doc_id == doc.doc_id)) {
            // بما أن Doctor.fromJson الآن تعالج الـ pivot و department_id داخلياً
            // ستحصل على كائن طبيب كامل البيانات تلقائياً
            allCombinedDoctors.add(doc);
          }
        }
      });
    }
    return allCombinedDoctors;
  }
}
