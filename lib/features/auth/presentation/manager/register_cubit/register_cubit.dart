import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:project_1/features/auth/data/repo/sign_up_repo/sign_up_repo.dart';
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

    result.fold(
      (failure) => emit(RegisterFailure(failure.errorMessage)),
      (user) => emit(RegisterSuccess(user)),
    );
  }
}
