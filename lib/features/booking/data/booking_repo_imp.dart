import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/features/booking/data/booking_repo.dart';
import 'package:project_1/models/appointments.dart';

class BookingRepoImpl implements BookingRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  BookingRepoImpl(
    this.dio, {
    this.secureStorage = const FlutterSecureStorage(),
  });

  @override
  Future<Either<Failure, List<Appointments>>> getUserAppointments() async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('No auth token found. Please login again.'));
      }

      var response = await dio.get(
        'https://medx.sy/api/appointments',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Appointments> appointmentsList = [];
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
          appointmentsList.add(Appointments.fromJson(item));
        }

        return Right(appointmentsList);
      } else {
        return Left(ServerFailure('Failed to fetch appointments.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppointmentNotes({
    required int appointmentId,
    required String userNotes,
  }) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('No auth token found. Please login again.'));
      }

      var response = await dio.put(
        'https://medx.sy/api/appointments/$appointmentId',
        data: {'user_notes': userNotes},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to update appointment notes.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required int appointmentId,
  }) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('No auth token found. Please login again.'));
      }

      var response = await dio.post(
        'https://medx.sy/api/appointments/$appointmentId/cancel',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(ServerFailure('Failed to cancel appointment.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> Rating({
    required String appointmentId,
    required double rating,
  }) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('No auth token found. Please login again.'));
      }

      final Map<String, dynamic> data = {'rating': rating};

      final response = await dio.put(
        'https://medx.sy/api/appointments/$appointmentId/refresh-ratings',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print('=== RATING API RESPONSE ===');
      print('Rating Value sent: $rating');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        String message = 'تم التقييم بنجاح';

        if (responseData is Map && responseData['message'] != null) {
          message = responseData['message'].toString();
        }

        return Right(message);
      } else {
        return Left(ServerFailure('Failed to submit rating.'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
