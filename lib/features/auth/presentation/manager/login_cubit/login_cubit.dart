import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/auth/data/repo/log_in_repo/log_in_repo.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:project_1/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInitial());
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    final String trimmedEmail = email.trim();
    final String trimmedPassword = password.trim();

    final result = await loginRepo.login(
      email: trimmedEmail,
      password: trimmedPassword,
    );

    result.fold(
      (failure) {
        emit(LoginFailure(failure.errorMessage));
      },
      (loginResponse) async {
        String? fcmToken;
        try {
          fcmToken = await FirebaseMessaging.instance.getToken();
        } catch (e) {
          print("تخطي خطأ المحاكي: $e");
        }
        if (fcmToken != null) {
          await NotificationsRepoImpl(Dio()).sendFcmToken(fcmToken);
        }
        final context = AppRouter.scaffoldMessengerKey.currentContext;
        if (context != null) {
          context.read<FavoritesCubit>().loadFavorites();
        }
        emit(LoginSuccess(loginResponse));
      },
    );
  }
}
