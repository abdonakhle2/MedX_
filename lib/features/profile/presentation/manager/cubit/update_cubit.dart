import 'package:flutter/material.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo.dart';
import 'package:project_1/models/user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart'; // تأكد من استيراد مكتبة Dio

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final ProfileRepo profileRepo;
  UpdateCubit(this.profileRepo) : super(UpdateInitial());

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? birthdate,
    String? address,
    String? gender,
    PlatformFile? idPassport,
  }) async {
    emit(UpdateLoading());

    final Map<String, dynamic> data = {};

    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone_number'] = phone;

    if (birthdate != null) {
      data['birthdate'] =
          "${birthdate.year}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}";
    }

    if (address != null) data['address'] = address;
    if (gender != null) data['gender'] = gender;
    if (idPassport != null) data['id_passport'] = idPassport;

    final result = await profileRepo.updateProfile(data: data);

    result.fold(
      (failure) => emit(UpdateError(errorMessage: failure.errorMessage)),
      (user) => emit(UpdateSuccess(user)),
    );
  }
}
