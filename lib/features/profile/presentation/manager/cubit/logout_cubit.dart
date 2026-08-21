import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final ProfileRepo profileRepo;

  LogoutCubit(this.profileRepo) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final result = await profileRepo.logout();

      result.fold((failure) => emit(LogoutError(failure.errorMessage)), (
        successMessage,
      ) {
        final context = AppRouter.scaffoldMessengerKey.currentContext;
        if (context != null) {
          context.read<FavoritesCubit>().clearFavorites();
        }
        emit(LogoutSuccess());
      });
    } catch (e) {
      emit(LogoutError('Failed to logout. Please try again.'));
    }
  }
}
