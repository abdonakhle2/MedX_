import 'package:dartz/dartz.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/clinic.dart';

abstract class FavoritesRepo {
  Future<Either<Failure, List<ClinicModel>>> getUserFavorites();
  Future<Either<Failure, String>> toggleFavorite(String clinicId);
}
