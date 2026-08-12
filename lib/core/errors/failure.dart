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

  // معالجة استجابة السيرفر بشكل آمن من الـ Null
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      // التعامل الآمن مع الاستجابة في حال كانت Map واستخراج الرسالة
      if (response is Map<String, dynamic> &&
          response.containsKey('error') &&
          response['error'] is Map &&
          response['error']['message'] != null) {
        return ServerFailure(response['error']['message'].toString());
      } else if (response is Map<String, dynamic> &&
          response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }
      return const ServerFailure('Authentication or validation error occurred');
    } else if (statusCode == 404) {
      return const ServerFailure(
        'Your request was not found, Please try later!',
      );
    } else if (statusCode == 500) {
      return const ServerFailure('Internal server error, Please try later!');
    } else {
      return const ServerFailure('Opps, There was an Error, Please try again');
    }
  }
}
