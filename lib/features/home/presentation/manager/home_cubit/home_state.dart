import 'package:project_1/models/clinic.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ClinicModel> clinics;
  HomeSuccess(this.clinics);
}

class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure(this.errorMessage);
}
