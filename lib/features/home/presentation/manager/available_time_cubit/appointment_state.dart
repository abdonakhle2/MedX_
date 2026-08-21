abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final List<String> availableTimes;

  AppointmentSuccess(this.availableTimes);
}

class AppointmentFailure extends AppointmentState {
  final String errorMessage;

  AppointmentFailure(this.errorMessage);
}
