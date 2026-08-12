import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> registerUser({
    required User user,
    PlatformFile? passportFile,
  });
}
