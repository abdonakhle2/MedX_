import 'package:dartz/dartz.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/notifications.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, List<NotificationModel>>> getUnreadNotifications();
  Future<Either<Failure, int>> getUnreadNotificationsCount();
  Future<Either<Failure, void>> sendFcmToken(String fcmToken);
  Future<Either<Failure, void>> markNotificationAsRead(String notificationId);
  Future<Either<Failure, void>> markAllNotificationsAsRead();
  Future<Either<Failure, void>> deleteFcmToken(String fcmToken);
}
