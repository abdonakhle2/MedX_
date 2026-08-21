import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo_impl.dart';
import 'package:project_1/features/home/presentation/manager/available_time_cubit/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final HomeRepo homeRepo;

  AppointmentCubit(this.homeRepo) : super(AppointmentInitial());

  Future<void> fetchAvailableTimes({
    required String departmentId,
    required String doctorId,
    required String date,
  }) async {
    if (doctorId.isEmpty) return;

    emit(AppointmentLoading());

    if (departmentId.isNotEmpty) {
      // Fast path: department is known
      final result = await homeRepo.getDoctorAvailableTimes(
        departmentId,
        doctorId,
        date,
      );
      result.fold(
        (failure) => emit(AppointmentFailure(failure.errorMessage)),
        (times) => emit(AppointmentSuccess(times)),
      );
    } else {
      // Fallback: search across all departments
      if (homeRepo is HomeRepoImpl) {
        final result = await (homeRepo as HomeRepoImpl)
            .findDoctorAvailableTimes(doctorId, date);
        result.fold(
          (failure) => emit(AppointmentFailure(failure.errorMessage)),
          (times) => emit(AppointmentSuccess(times)),
        );
      } else {
        emit(AppointmentFailure('Department ID is required'));
      }
    }
  }
}
