import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_state.dart';
import 'package:project_1/core/widgets/custom_error_widget.dart';
import 'package:project_1/core/widgets/shimmer_clinic.dart';
import 'package:project_1/constants/constants.dart';

class CustomHomeList extends StatefulWidget {
  const CustomHomeList({super.key});

  @override
  State<CustomHomeList> createState() => _CustomHomeListState();
}

class _CustomHomeListState extends State<CustomHomeList> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // جلب العيادات عند فتح القائمة
    context.read<HomeCubit>().fetchClinics();
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // شريط البحث الخاص بالمراكز الطبية
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: localeText.searchHint,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // بناء القائمة بناءً على حالة الـ Cubit
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ShimmerClinic();
                },
              );
            } else if (state is HomeSuccess) {
              if (state.clinics.isEmpty) {
                return _buildEmptyState(
                  context,
                  icon: Icons.domain_disabled_rounded,
                  title: localeText.homeEmptyCentersTitle,
                  subtitle: localeText.homeEmptyCentersSubtitle,
                );
              }

              // تصفية العيادات بناءً على نص البحث
              var filteredClinics = state.clinics.where((clinic) {
                final nameEn = clinic.name_en?.toLowerCase() ?? '';
                final nameAr = clinic.name_ar?.toLowerCase() ?? '';
                final query = searchQuery.toLowerCase();
                return nameEn.contains(query) || nameAr.contains(query);
              }).toList();

              if (filteredClinics.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      localeText.noResultSearch,
                      style: AppFonts.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              }

              return BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  final favoritesCubit = context.read<FavoritesCubit>();
                  final sortedClinics = List.from(filteredClinics);
                  sortedClinics.sort((a, b) {
                    final aFav = favoritesCubit.isFavorite(a.clinic_id) ? 1 : 0;
                    final bFav = favoritesCubit.isFavorite(b.clinic_id) ? 1 : 0;
                    return bFav.compareTo(aFav);
                  });

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sortedClinics.length,
                    itemBuilder: (context, index) {
                      final clinic = sortedClinics[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CardClinic(clinic: clinic),
                      );
                    },
                  );
                },
              );
            } else if (state is HomeFailure) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomErrorWidget(
                  errorMessage: state.errorMessage,
                  onRetry: () {
                    context.read<HomeCubit>().fetchClinics();
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor.withOpacity(0.15), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
