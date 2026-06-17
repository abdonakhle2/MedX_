import 'package:project_1/models/clinic.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<ClinicModel> favoriteClinics;

  FavoritesLoaded(this.favoriteClinics);
}

class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}
