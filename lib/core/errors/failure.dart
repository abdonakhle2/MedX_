import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';

void handleUnauthorizedError() async {
  const secureStorage = FlutterSecureStorage();
  await secureStorage.delete(key: 'auth_token');

  final context = AppRouter.scaffoldMessengerKey.currentContext;
  final localeText = context != null ? AppLocalizations.of(context) : null;
  final message =
      localeText?.sessionExpiredMessage ??
      'Session expired. Please login again.';

  AppRouter.scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 4),
    ),
  );

  AppRouter.router.go(AppRouter.kLogInScreen);
}

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    final context = AppRouter.scaffoldMessengerKey.currentContext;
    final localeText = context != null ? AppLocalizations.of(context) : null;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          localeText?.errorConnectionTimeout ??
              'Connection timeout with API server',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          localeText?.errorSendTimeout ??
              'Send timeout in connection with API server',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          localeText?.errorReceiveTimeout ??
              'Receive timeout in connection with API server',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          localeText?.errorBadCertificate ?? 'Bad certificate',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure(
          localeText?.errorRequestCanceled ??
              'Request to API server was cancelled',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          localeText?.errorNoInternet ?? 'No internet connection',
        );

      case DioExceptionType.unknown:
        if (dioException.message != null &&
            dioException.message!.contains('SocketException')) {
          return ServerFailure(
            localeText?.errorNoInternet ?? 'No internet connection',
          );
        }
        return ServerFailure(
          localeText?.errorUnexpected ?? 'Unexpected error occurred',
        );

      default:
        return ServerFailure(
          localeText?.errorOops ?? 'Oops, There was an error, Please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    final context = AppRouter.scaffoldMessengerKey.currentContext;
    final localeText = context != null ? AppLocalizations.of(context) : null;

    if (statusCode == 401 || statusCode == 403) {
      handleUnauthorizedError();
      if (response is Map<String, dynamic> &&
          response.containsKey('message') &&
          response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }
      return ServerFailure(
        localeText?.errorUnauthorized ?? 'Unauthorized access',
      );
    }

    if (statusCode == 404) {
      return ServerFailure(
        localeText?.errorNotFound ??
            'Your request was not found, Please try later!',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        localeText?.errorInternalServer ??
            'Internal server error, Please try later',
      );
    } else if (statusCode == 422) {
      if (response is Map<String, dynamic> && response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }
      return ServerFailure(localeText?.errorValidation ?? 'Validation error');
    }

    if (response is Map<String, dynamic>) {
      if (response.containsKey('message') && response['message'] != null) {
        return ServerFailure(response['message'].toString());
      }

      if (response.containsKey('error')) {
        final errorField = response['error'];
        if (errorField is String) {
          return ServerFailure(errorField);
        } else if (errorField is Map && errorField['message'] != null) {
          return ServerFailure(errorField['message'].toString());
        }
      }
    }

    final statusCodeText =
        localeText?.errorStatusCode ??
        'Opps There was an Error, Please try again with status code';
    return ServerFailure(
      response is Map && response.containsKey('message')
          ? response['message'].toString()
          : '$statusCodeText $statusCode',
    );
  }
}
