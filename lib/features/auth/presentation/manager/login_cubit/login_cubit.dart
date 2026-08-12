import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_1/features/auth/data/repo/log_in_repo/log_in_repo.dart';
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

    final result = await loginRepo.login(email: email, password: password);

    result.fold(
      (failure) {
        emit(LoginFailure(failure.errorMessage));
      },
      (loginResponse) async {
        // حفظ التوكن عند النجاح

        emit(LoginSuccess(loginResponse));
      },
    );
  }
}
