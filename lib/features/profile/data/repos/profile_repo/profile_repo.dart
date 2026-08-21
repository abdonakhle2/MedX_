import 'package:dartz/dartz.dart'; // أو يمكنك استخدام Either لمعالجة الأخطاء
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/user.dart';

abstract class ProfileRepo {
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, User>> updateProfile({
    required Map<String, dynamic> data,
  });
}
