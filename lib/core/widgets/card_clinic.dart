import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_state.dart';

String _getClinicImageUrl(ClinicModel clinic) {
  final urls = [
    'https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80',
  ];
  final index = clinic.name_en.hashCode.abs() % urls.length;
  return urls[index];
}

class CardClinic extends StatefulWidget {
  final ClinicModel clinic;
  const CardClinic({super.key, required this.clinic});

  @override
  State<CardClinic> createState() => _CardClinicState();
}

class _CardClinicState extends State<CardClinic> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CenterDetailsScreen()),
          // );
          GoRouter.of(
            context,
          ).push(AppRouter.kCenterDetailsScreen, extra: widget.clinic);
        },
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section with gradient overlay
                  Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              widget.clinic.logo.isNotEmpty
                                  ? Uri.encodeFull(widget.clinic.logo)
                                  : _getClinicImageUrl(widget.clinic),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.network(
                                _getClinicImageUrl(widget.clinic),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.primary.withOpacity(0.12),
                                  child: const Center(
                                    child: Icon(
                                      Icons.local_hospital_rounded,
                                      size: 44,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.15),
                                    Colors.black.withOpacity(0.4),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Gradient overlay at bottom
                      // Positioned(
                      //   bottom: 0,
                      //   left: 0,
                      //   right: 0,
                      //   child: Container(
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //         colors: [
                      //           Colors.black.withOpacity(0.15),
                      //           Colors.transparent,
                      //           colorScheme.surface.withOpacity(0.9),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isDarkMode ? [] : AppShadows.softShadow,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final isFavorite = context
                                      .read<FavoritesCubit>()
                                      .isFavorite(widget.clinic.clinic_id);
                                  return IconButton(
                                    onPressed: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavorite(widget.clinic);
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? AppColors.error
                                          : AppColors.secondary,
                                      size: 20,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag and Rating
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.tertiary.withOpacity(0.2),
                                    AppColors.tertiary.withOpacity(0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                localeText.appointmentPrimaryFacility,
                                style: AppFonts.labelSmall.copyWith(
                                  color: Color(0xFF2DD4BF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.amber.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.clinic.rating.toString(),
                                    style: AppFonts.labelMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Hospital name
                        Text(
                          Localizations.localeOf(context).languageCode ==
                                      'ar' &&
                                  widget.clinic.name_ar.isNotEmpty
                              ? widget.clinic.name_ar
                              : widget.clinic.name_en,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          Localizations.localeOf(context).languageCode ==
                                      'ar' &&
                                  widget.clinic.description_ar.isNotEmpty
                              ? widget.clinic.description_ar
                              : widget.clinic.description_en,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 16),
                        Container(height: 1, color: theme.dividerColor),
                        const SizedBox(height: 16),

                        // Distance and Arrow
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? const Color(0xFF334155)
                                    : AppColors.greyLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.location_on_rounded,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              Localizations.localeOf(context).languageCode ==
                                          'ar' &&
                                      widget.clinic.location_ar.isNotEmpty
                                  ? widget.clinic.location_ar
                                  : widget.clinic.location_en,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
