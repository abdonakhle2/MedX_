import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/booking/data/booking_repo.dart';
import 'package:project_1/features/booking/presentation/manager/cancel_appintment_cubit/cancel_appointment_state.dart';

class CancelAppointmentCubit extends Cubit<CancelAppointmentState> {
  final BookingRepo bookingRepo;

  CancelAppointmentCubit(this.bookingRepo) : super(CancelAppointmentInitial());

  Future<void> cancelAppointment({required int appointmentId}) async {
    emit(CancelAppointmentLoading());
    final result = await bookingRepo.cancelAppointment(
      appointmentId: appointmentId,
    );

    result.fold(
      (failure) => emit(CancelAppointmentFailure(failure.errorMessage)),
      (_) => emit(CancelAppointmentSuccess()),
    );
  }
}
