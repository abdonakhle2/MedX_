import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo.dart';
import 'package:project_1/models/user.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  User? cachedUser;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> loadProfile() async {
    if (cachedUser != null) {
      emit(ProfileLoaded(cachedUser!));
      return;
    }

    emit(ProfileLoading());

    try {
      final result = await profileRepo.getUserProfile();

      result.fold((failure) => emit(ProfileError(failure.errorMessage)), (
        user,
      ) {
        cachedUser = user;
        emit(ProfileLoaded(user));
      });
    } catch (e) {
      emit(ProfileError('Failed to load profile data.'));
    }
  }

  // Helper method to clear cache if needed (e.g. on logout)
  void clearCache() {
    cachedUser = null;
    emit(ProfileInitial());
  }

  Future<void> refreshProfile() async {
    emit(ProfileLoading());
    final result = await profileRepo.getUserProfile();

    result.fold((failure) => emit(ProfileError(failure.errorMessage)), (user) {
      cachedUser = user;
      emit(ProfileLoaded(user));
    });
  }

  void updateUserCache(User updatedUser) {
    cachedUser = updatedUser;
    emit(ProfileLoaded(updatedUser));
  }
}
