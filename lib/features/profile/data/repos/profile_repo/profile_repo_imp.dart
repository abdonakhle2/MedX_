import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // استدعاء المكتبة مباشرة
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:project_1/models/user.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  ProfileRepoImpl(this.dio, {FlutterSecureStorage? secureStorage})
    : secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        handleUnauthorizedError();
        return Left(
          ServerFailure(
            AppLocalizations.of(
                  AppRouter.scaffoldMessengerKey.currentContext!,
                )?.errorNoAuthToken ??
                'No auth token found. Please login again.',
          ),
        );
      }

      final response = await dio.get(
        'https://medx.sy/api/profile/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final userData = response.data is Map<String, dynamic>
          ? response.data
          : response.data['user'] ?? response.data;

      return Right(User.fromJson(userData));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      try {
        if (token != null && token.isNotEmpty) {
          final response = await dio.post(
            'https://medx.sy/api/profile/logout',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
            ),
          );

          print('status code : ${response.statusCode}');
        }
      } on DioException catch (e) {
        print(
          'Logout request failed, but the app will still log the user out locally: $e',
        );
      }
      String? fcmToken;
      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print("خطأ في جلب التوكن: $e");
      }

      if (fcmToken != null) {
        // 2. نحذف التوكن من السيرفر
        await NotificationsRepoImpl(Dio()).deleteFcmToken(fcmToken);
      }
      await secureStorage.delete(key: 'auth_token');
      return Right(
        AppLocalizations.of(
              AppRouter.scaffoldMessengerKey.currentContext!,
            )?.logoutSuccess ??
            'Logged out successfully',
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        handleUnauthorizedError();
        return Left(
          ServerFailure(
            AppLocalizations.of(
                  AppRouter.scaffoldMessengerKey.currentContext!,
                )?.errorNoAuthToken ??
                'No auth token found. Please login again.',
          ),
        );
      }

      // استخراج ملف الجواز إذا كان من نوع PlatformFile أو File
      PlatformFile? passportFile;
      if (data.containsKey('id_passport')) {
        if (data['id_passport'] is PlatformFile) {
          passportFile = data['id_passport'];
          data.remove(
            'id_passport',
          ); // إزالته من الـ map العادية لكي لا يرسل كنص
        }
      }

      // تحويل البيانات إلى FormData
      FormData formData = FormData.fromMap(data);

      // إرسال الملف بالطريقة الصحيحة عبر الـ Multipart
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

      final response = await dio.post(
        'https://medx.sy/api/profile/update',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print("--- Response Data ---");
      print(response.data); // هذا يطبع كامل استجابة السيرفر
      print("--- Passport in Response ---");
      print(response.data['user']?['id_passport']);
      final userData = response.data is Map<String, dynamic>
          ? (response.data['user'] ?? response.data)
          : response.data;

      return Right(User.fromJson(userData));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
