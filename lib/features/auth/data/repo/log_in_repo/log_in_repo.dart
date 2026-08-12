import 'package:dartz/dartz.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/user.dart';

abstract class LoginRepo {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
}
