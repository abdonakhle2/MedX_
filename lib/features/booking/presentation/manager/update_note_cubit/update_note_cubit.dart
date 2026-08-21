import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/booking/data/booking_repo.dart';
import 'package:project_1/features/booking/presentation/manager/update_note_cubit/update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteState> {
  final BookingRepo bookingRepo;

  UpdateNoteCubit(this.bookingRepo) : super(UpdateNoteInitial());

  Future<void> updateAppointmentNotes({
    required int appointmentId,
    required String userNotes,
  }) async {
    emit(UpdateNoteLoading());

    final result = await bookingRepo.updateAppointmentNotes(
      appointmentId: appointmentId,
      userNotes: userNotes,
    );

    result.fold(
      (failure) => emit(UpdateNoteFailure(failure.errorMessage)),
      (_) => emit(UpdateNoteSuccess()),
    );
  }
}
