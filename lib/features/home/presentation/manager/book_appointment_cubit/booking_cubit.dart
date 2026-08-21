import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo.dart';
import 'package:project_1/features/home/presentation/manager/book_appointment_cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final HomeRepo homeRepo;

  BookingCubit(this.homeRepo) : super(BookingInitial());

  Future<void> bookAppointment({
    required String doctorId,
    required String depId,
    required String date,
    required String time,
    required int isAsap,
    required String userNotes,
  }) async {
    emit(BookingLoading());

    final result = await homeRepo.bookAppointment(
      doctorId: doctorId,
      depId: depId,
      date: date,
      time: time,
      isAsap: isAsap,
      userNotes: userNotes,
    );

    result.fold(
      (failure) => emit(BookingFailure(failure.errorMessage)),
      (responseData) => emit(
        BookingSuccess(responseData),
      ), // تصحيح هنا لتمرير responseData بدلاً من result
    );
  }
}
