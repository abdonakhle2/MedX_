import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/models/user.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void loadProfile() {
    emit(ProfileLoading());
    try {
      emit(ProfileLoaded(User.currentUser));
    } catch (e) {
      emit(ProfileError("Failed to load profile data."));
    }
  }

  void updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String? phone,
    required DateTime? birthdate,
    required String address,
    required String? idPassport,
  }) {
    emit(ProfileUpdating());
    try {
      // Simulate network request or perform update locally
      User.currentUser.firstName = firstName;
      User.currentUser.lastName = lastName;
      User.currentUser.email = email;
      User.currentUser.phoneNumber = phone;
      User.currentUser.birthdate = birthdate;
      User.currentUser.address = address;
      User.currentUser.idPassport = idPassport;

      emit(ProfileUpdateSuccess(User.currentUser));
      // Re-emit loaded so current state is accurate
      emit(ProfileLoaded(User.currentUser));
    } catch (e) {
      emit(ProfileError("Failed to update profile data."));
    }
  }
}
