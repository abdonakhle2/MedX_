import 'package:project_1/models/appointments.dart';

abstract class UserAppointmentsState {}

class UserAppointmentsInitial extends UserAppointmentsState {}

class UserAppointmentsLoading extends UserAppointmentsState {}

class UserAppointmentsSuccess extends UserAppointmentsState {
  final List<Appointments> appointments;
  UserAppointmentsSuccess(this.appointments);
}

class UserAppointmentsFailure extends UserAppointmentsState {
  final String errorMessage;
  UserAppointmentsFailure(this.errorMessage);
}
