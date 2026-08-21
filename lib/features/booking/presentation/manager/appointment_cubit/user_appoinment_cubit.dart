import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/booking/data/booking_repo.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appointment_state.dart';

class UserAppointmentsCubit extends Cubit<UserAppointmentsState> {
  final BookingRepo bookingRepo;

  UserAppointmentsCubit(this.bookingRepo) : super(UserAppointmentsInitial());
  Future<void> fetchUserAppointments() async {
    // 1. تحقق مما إذا كان الـ Cubit مغلقاً قبل إصدار حالة التحميل
    if (isClosed) return;
    emit(UserAppointmentsLoading());

    final result = await bookingRepo.getUserAppointments();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) emit(UserAppointmentsFailure(failure.errorMessage));
      },
      (appointments) {
        if (!isClosed) emit(UserAppointmentsSuccess(appointments));
      },
    );
  }
}
