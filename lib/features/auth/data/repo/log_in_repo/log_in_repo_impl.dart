import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/features/auth/data/repo/log_in_repo/log_in_repo.dart';
import 'package:project_1/models/user.dart';

class LoginRepoImpl implements LoginRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginRepoImpl(this.dio);
  Future<bool> isUserLoggedIn() async {
    String? token = await secureStorage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({'email': email, 'password': password});

      final response = await dio.post(
        'https://medx.sy/api/auth/login',
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      // 1. حفظ التوكين من المفتاح الرئيسي "token"
      if (response.data['token'] != null) {
        await secureStorage.write(
          key: 'auth_token',
          value: response.data['token'],
        );
        print('token :  ${response.data['token']}');
        print('status code : ${response.statusCode}');
      }

      // 2. تحويل كائن "user" فقط إلى نموذج User
      final loginResponse = User.fromJson(response.data['user']);
      // final loginResponse = User.fromJson(response.data['user']);
      print('User Data: ${response.data['user']}');
      // print('User Name: ${loginResponse.firstName}');
      return Right(loginResponse);
    } catch (e) {
      if (e is DioException) {
        print('====== DIO EXCEPTION ERROR ======');
        print('Type: ${e.type}');
        print('Message: ${e.message}');
        print('Response Data: ${e.response?.data}');
        print('Status Code: ${e.response?.statusCode}');
        return Left(ServerFailure.fromDioException(e));
      }
      print('====== UNKNOWN ERROR: $e ======');
      return Left(ServerFailure(e.toString()));
    }
  }
}
