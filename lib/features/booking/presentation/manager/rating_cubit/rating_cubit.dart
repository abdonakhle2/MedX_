import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/booking/data/booking_repo.dart'; // تم التعديل هنا لاستيراد الـ BookingRepo
import 'package:project_1/features/booking/presentation/manager/rating_cubit/rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final BookingRepo bookingRepo;

  RatingCubit(this.bookingRepo) : super(RatingInitial());

  Future<void> submitRating({
    required String appointmentId,
    required double rating,
  }) async {
    emit(RatingLoading());

    final result = await bookingRepo.Rating(
      appointmentId: appointmentId,
      rating: rating,
    );

    result.fold(
      (failure) => emit(RatingFailure(errMessage: failure.errorMessage)),
      (successMessage) => emit(RatingSuccess(message: successMessage)),
    );
  }
}
