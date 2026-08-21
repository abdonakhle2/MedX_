abstract class CancelAppointmentState {}

class CancelAppointmentInitial extends CancelAppointmentState {}

class CancelAppointmentLoading extends CancelAppointmentState {}

class CancelAppointmentSuccess extends CancelAppointmentState {}

class CancelAppointmentFailure extends CancelAppointmentState {
  final String errorMessage;
  CancelAppointmentFailure(this.errorMessage);
}
