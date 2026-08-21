import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/features/auth/data/repo/sign_up_repo/sign_up_repo.dart';
import 'package:project_1/models/user.dart';

class AuthRepoImpl implements AuthRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthRepoImpl(this.dio);

  @override
  Future<Either<Failure, User>> registerUser({
    required User user,
    PlatformFile? passportFile,
  }) async {
    try {
      print("Name: ${user.firstName} ${user.lastName}");
      print("Email: ${user.email}");
      print("Phone: ${user.phoneNumber}");
      print("Password: ${user.password}");
      print("ID/Passport Text: ${user.idPassport}");
      print("Birthdate: ${user.birthdate}");
      print("Gender: ${user.gender}");
      print("Address: ${user.address}");

      Map<String, dynamic> mapData = {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password': user.password,
        'password_confirmation': user.confirmPassword,
        'gender': user.gender,
        'address': user.address,
        'birthdate': user.birthdate != null
            ? "${user.birthdate!.year}-${user.birthdate!.month.toString().padLeft(2, '0')}-${user.birthdate!.day.toString().padLeft(2, '0')}"
            : null,
      };

      // 2. إنشاء الـ FormData
      FormData formData = FormData.fromMap(mapData);

      // 3. إضافة الملف بشكل صحيح إذا كان موجوداً
      if (passportFile != null) {
        if (passportFile.bytes != null) {
          formData.files.add(
            MapEntry(
              'id_passport',
              MultipartFile.fromBytes(
                passportFile.bytes!,
                filename: passportFile.name,
              ),
            ),
          );
        } else if (passportFile.path != null) {
          formData.files.add(
            MapEntry(
              'id_passport',
              await MultipartFile.fromFile(
                passportFile.path!,
                filename: passportFile.name,
              ),
            ),
          );
        }
      }
      var response = await dio.post(
        'https://medx.sy/api/auth/register',
        data: formData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.data['token'] != null) {
        await secureStorage.write(
          key: 'auth_token',
          value: response.data['token'],
        );
        print('token : ${response.data['token']}');
      }

      User responseUser = User.fromJson(response.data['user']);
      return Right(responseUser);
    } on DioException catch (e) {
      print("Dio Error Response: ${e.response?.data}");
      print("Dio Error Status Code: ${e.response?.statusCode}");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      print("Unexpected Error: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<bool> isUserLoggedIn() async {
    const secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }
}
