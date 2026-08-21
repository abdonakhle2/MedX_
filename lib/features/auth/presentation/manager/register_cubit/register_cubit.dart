import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/auth/data/repo/sign_up_repo/sign_up_repo.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:project_1/models/user.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  Future<void> registerUser({
    required User user,
    PlatformFile? passportFile,
  }) async {
    emit(RegisterLoading());

    final result = await authRepo.registerUser(
      user: user,
      passportFile: passportFile,
    );

    result.fold((failure) => emit(RegisterFailure(failure.errorMessage)), (
      user,
    ) async {
      String? fcmToken;
      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print("تخطي خطأ المحاكي: $e");
      }

      // ثم تمريره للـ Repository إذا كان موجوداً
      if (fcmToken != null) {
        await NotificationsRepoImpl(Dio()).sendFcmToken(fcmToken);
      }
      final context = AppRouter.scaffoldMessengerKey.currentContext;
      if (context != null) {
        context.read<FavoritesCubit>().loadFavorites();
      }
      emit(RegisterSuccess(user));
    });
  }
}
