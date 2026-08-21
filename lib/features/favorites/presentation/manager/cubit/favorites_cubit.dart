import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/favorites/data/repos/favorites_repo.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo favoritesRepo;

  FavoritesCubit(this.favoritesRepo) : super(FavoritesInitial());

  final List<ClinicModel> favoriteClinics = [];
  void clearFavorites() {
    favoriteClinics.clear();
    emit(FavoritesInitial());
  }

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());

    final result = await favoritesRepo.getUserFavorites();

    result.fold((failure) => emit(FavoritesError(failure.errorMessage)), (
      clinics,
    ) {
      favoriteClinics.clear();
      favoriteClinics.addAll(clinics);
      emit(FavoritesLoaded(List.from(favoriteClinics)));
    });
  }

  Future<void> toggleFavorite(ClinicModel clinic) async {
    final bool isExist = favoriteClinics.any(
      (c) => c.clinic_id == clinic.clinic_id,
    );

    // Optimistic UI update
    if (isExist) {
      favoriteClinics.removeWhere((c) => c.clinic_id == clinic.clinic_id);
    } else {
      favoriteClinics.add(clinic);
    }
    emit(FavoritesLoaded(List.from(favoriteClinics)));

    // Remote update
    final result = await favoritesRepo.toggleFavorite(clinic.clinic_id);

    result.fold(
      (failure) {
        // Rollback on failure because we strictly rely on the server
        if (isExist) {
          favoriteClinics.add(clinic);
        } else {
          favoriteClinics.removeWhere((c) => c.clinic_id == clinic.clinic_id);
        }

        // Show error to the user
        final context = AppRouter.scaffoldMessengerKey.currentContext;
        if (context != null) {
          final localeText = AppLocalizations.of(context)!;
          AppRouter.scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(failure.errorMessage),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: localeText.errorRetry,
                textColor: Colors.white,
                onPressed: () {
                  toggleFavorite(clinic);
                },
              ),
            ),
          );
        }

        emit(FavoritesLoaded(List.from(favoriteClinics)));
      },
      (successMessage) {
        // Already updated optimistically
        final context = AppRouter.scaffoldMessengerKey.currentContext;
        if (context != null) {
          final localeText = AppLocalizations.of(context)!;
          final message = isExist
              ? localeText.favoritesRemoved
              : localeText.favoritesAdded;

          AppRouter.scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: isExist ? Colors.grey[800] : Colors.green,
              // duration: const Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }

  bool isFavorite(String clinicId) {
    return favoriteClinics.any((c) => c.clinic_id == clinicId);
  }
}
