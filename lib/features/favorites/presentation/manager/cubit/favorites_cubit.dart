import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/models/clinic.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final List<ClinicModel> _favoriteClinics = [];

  void loadFavorites() {
    emit(FavoritesLoading());
    try {
      emit(FavoritesLoaded(List.from(_favoriteClinics)));
    } catch (e) {
      emit(FavoritesError("Failed to load favorites"));
    }
  }

  void toggleFavorite(ClinicModel clinic) {
    emit(FavoritesLoading());
    try {
      final isExist = _favoriteClinics.any((c) => c.clinic_id == clinic.clinic_id);
      
      if (isExist) {
        _favoriteClinics.removeWhere((c) => c.clinic_id == clinic.clinic_id);
      } else {
        _favoriteClinics.add(clinic);
      }
      
      emit(FavoritesLoaded(List.from(_favoriteClinics)));
    } catch (e) {
      emit(FavoritesError("Failed to update favorite status"));
    }
  }

  bool isFavorite(String clinicId) {
    return _favoriteClinics.any((c) => c.clinic_id == clinicId);
  }
}
