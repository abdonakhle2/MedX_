abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final Map<String, dynamic> appointmentDetails;

  BookingSuccess(this.appointmentDetails);
}

class BookingFailure extends BookingState {
  final String errorMessage;
  BookingFailure(this.errorMessage);
}
