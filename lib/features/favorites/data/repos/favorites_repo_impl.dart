import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/clinic.dart';
import 'favorites_repo.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  FavoritesRepoImpl(this.dio, {FlutterSecureStorage? secureStorage})
    : secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<Either<Failure, List<ClinicModel>>> getUserFavorites() async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        handleUnauthorizedError();
        return const Left(
          ServerFailure('No auth token found. Please login again.'),
        );
      }

      final response = await dio.get(
        'https://medx.sy/api/favorites/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      List<ClinicModel> favoritesList = [];

      var data = response.data;
      // Handle various response wrappers recursively
      while (data is Map<String, dynamic>) {
        if (data.containsKey('data')) {
          data = data['data'];
        } else if (data.containsKey('favourites')) {
          data = data['favourites'];
        } else if (data.containsKey('favorites')) {
          data = data['favorites'];
        } else if (data.containsKey('clinics')) {
          data = data['clinics'];
        } else {
          break;
        }
      }

      if (data is List) {
        favoritesList = data.map((item) {
          if (item is Map<String, dynamic>) {
            // If the item itself is a wrapper containing 'clinic'
            if (item.containsKey('clinic') && item['clinic'] is Map) {
              return ClinicModel.fromJson(item['clinic'] as Map<String, dynamic>);
            }
            return ClinicModel.fromJson(item);
          }
          return null;
        }).whereType<ClinicModel>().toList();
      }

      return Right(favoritesList);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Right([]);
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> toggleFavorite(String clinicId) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        handleUnauthorizedError();
        return const Left(
          ServerFailure('No auth token found. Please login again.'),
        );
      }

      final response = await dio.post(
        'https://medx.sy/api/favorites/toggle/$clinicId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      String message = 'Success';
      if (response.data is Map<String, dynamic> &&
          response.data['message'] != null) {
        message = response.data['message'].toString();
      }

      return Right(message);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
