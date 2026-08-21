import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/favorites/presentation/view/widgets/custom_favorites_app_bar.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_state.dart';
import 'package:project_1/core/widgets/custom_error_widget.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localeText = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return CustomScrollView(
              slivers: [
                const CustomFavoritesAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Shimmer.fromColors(
                        baseColor: colorScheme.surfaceContainerHighest,
                        highlightColor: colorScheme.surface,
                        child: Container(
                          height: 140, // Approximate height of CardClinic
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    );
                  }, childCount: 6),
                ),
              ],
            );
          } else if (state is FavoritesLoaded) {
            final favoriteClinics = state.favoriteClinics;

            if (favoriteClinics.isEmpty) {
              return CustomScrollView(
                slivers: [
                  const CustomFavoritesAppBar(),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              size: 64,
                              color: colorScheme.onSurface.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              localeText.favoritesEmpty,
                              style: TextStyle(
                                fontSize: 16,
                                color: colorScheme.onSurface.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return CustomScrollView(
              slivers: [
                const CustomFavoritesAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CardClinic(clinic: favoriteClinics[index]),
                    );
                  }, childCount: favoriteClinics.length),
                ),
              ],
            );
          } else if (state is FavoritesError) {
            return CustomScrollView(
              slivers: [
                const CustomFavoritesAppBar(),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomErrorWidget(
                      errorMessage: state.message,
                      onRetry: () {
                        context.read<FavoritesCubit>().loadFavorites();
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
