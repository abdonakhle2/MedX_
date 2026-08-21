import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/widgets/card_clinic.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/widgets/custom_error_widget.dart';
import 'package:project_1/core/widgets/shimmer_clinic.dart';

class CustomResultSearchList extends StatelessWidget {
  const CustomResultSearchList({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    return BlocBuilder<HomeCubit, HomeState>(
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
          final filteredClinics = state.clinics.where((clinic) {
            final queryWithoutSpaces = searchQuery.toLowerCase().replaceAll(
              ' ',
              '',
            );

            final nameEn = clinic.name_en.toLowerCase().replaceAll(' ', '');
            final nameAr = clinic.name_ar.toLowerCase().replaceAll(' ', '');
            final locEn = clinic.location_en.toLowerCase().replaceAll(' ', '');
            final locAr = clinic.location_ar.toLowerCase().replaceAll(' ', '');

            return nameEn.contains(queryWithoutSpaces) ||
                nameAr.contains(queryWithoutSpaces) ||
                locEn.contains(queryWithoutSpaces) ||
                locAr.contains(queryWithoutSpaces);
          }).toList();

          if (filteredClinics.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  localeText.homeEmptyCentersSubtitle,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: filteredClinics.length,
            itemBuilder: (context, index) {
              final clinic = filteredClinics[index];

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 15 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: CardClinic(clinic: clinic),
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
    );
  }
}
