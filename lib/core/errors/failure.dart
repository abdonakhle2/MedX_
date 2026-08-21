import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

  // استخدام DioException بدلاً من DioError القديمة
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad certificate with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.connectionError:
        return const ServerFailure('No Internet Connection / Connection Error');

      case DioExceptionType.unknown:
        // التحقق الآمن من الرسالة لتجنب Null Error
        if (dioException.message != null &&
            dioException.message!.contains('SocketException')) {
          return const ServerFailure('No Internet Connection');
        }
        return const ServerFailure('Unexpected Error, Please try again!');

      default:
        return const ServerFailure(
          'Opps, There was an Error, Please try again',
        );
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    // 1. إذا كانت الاستجابة عبارة عن Map (JSON)
    if (response is Map<String, dynamic>) {
      // التحقق من وجود مفتاح 'message' مباشرة (مثل أخطاء الـ Validation في لاراول)
      if (response.containsKey('message') && response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }

      // التحقق من وجود مفتاح 'error' إذا كان يحتوي على رسالة نصية
      if (response.containsKey('error')) {
        final errorField = response['error'];
        if (errorField is String) {
          return ServerFailure(errorField);
        } else if (errorField is Map && errorField['message'] != null) {
          return ServerFailure(errorField['message'].toString());
        }
      }
    }

    // 2. التعامل مع الأكواد الشهيرة بشكل آمن
    if (statusCode == 401 || statusCode == 403) {
      return const ServerFailure('Unauthorized / Forbidden access');
    } else if (statusCode == 404) {
      return const ServerFailure('Request not found, Please try later!');
    } else if (statusCode == 422) {
      // أخطاء التحقق (Validation Errors) غالباً ما ترسل رسالة في 'message' أو الأخطاء مباشرة
      if (response is Map<String, dynamic> && response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }
      return const ServerFailure('Validation Error, Please check your inputs.');
    } else if (statusCode == 500) {
      return const ServerFailure('Internal server error, Please try later!');
    } else {
      // 3. الحل الاحتياطي النهائي في حال لم تطابق أي شروط
      return ServerFailure(
        response is Map && response.containsKey('message')
            ? response['message'].toString()
            : 'Opps, There was an Error, Status Code: $statusCode',
      );
    }
  }
}
