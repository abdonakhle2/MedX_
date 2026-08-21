import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/notifications.dart';
import 'notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final Dio dio;
  NotificationsRepoImpl(this.dio);

  // 1. جلب كل الإشعارات
  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      final response = await dio.get(
        'https://medx.sy/api/profile/notifications',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      List data = response.data['data'];
      List<NotificationModel> notifications = data
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      return Right(notifications);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 2. جلب الإشعارات غير المقروءة فقط
  @override
  Future<Either<Failure, List<NotificationModel>>>
  getUnreadNotifications() async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      final response = await dio.get(
        'https://medx.sy/api/profile/notifications',
        queryParameters: {'unread_only': true},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      List data = response.data['data'];
      List<NotificationModel> notifications = data
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      return Right(notifications);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 3. جلب عدد الإشعارات غير المقروءة
  @override
  Future<Either<Failure, int>> getUnreadNotificationsCount() async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      final response = await dio.get(
        'https://medx.sy/api/profile/notifications/unread-count',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      int count = response.data['unread_count'] ?? 0;
      return Right(count);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 4. تخزين الـ FCM Token
  @override
  Future<Either<Failure, void>> sendFcmToken(String fcmToken) async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      String deviceType = Platform.isAndroid ? 'android' : 'iphone';
      String deviceName = await _getDeviceName();

      await dio.post(
        'https://medx.sy/api/profile/fcm-tokens',
        data: {
          'token': fcmToken,
          'device_type': deviceType,
          'device_name': deviceName,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 5. جعل إشعار معين مقروءاً
  @override
  Future<Either<Failure, void>> markNotificationAsRead(
    String notificationId,
  ) async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      await dio.patch(
        'https://medx.sy/api/profile/notifications/$notificationId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 6. جعل كل الإشعارات مقروءة
  @override
  Future<Either<Failure, void>> markAllNotificationsAsRead() async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      await dio.patch(
        'https://medx.sy/api/profile/notifications/read-all',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // 7. حذف الـ FCM Token
  @override
  Future<Either<Failure, void>> deleteFcmToken(String fcmToken) async {
    try {
      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'auth_token');

      await dio.delete(
        'https://medx.sy/api/profile/fcm-tokens',
        queryParameters: {'token': fcmToken},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // دالة مساعدة لمعرفة اسم الجهاز
  Future<String> _getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
    return 'Unknown Device';
  }
}
