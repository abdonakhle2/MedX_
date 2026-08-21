import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/utils/function/custom_snack_bar.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo_imp.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/logout_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/logout_state.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';

class CustomLogOutButton extends StatelessWidget {
  const CustomLogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final errorColor = colorScheme.error;
    final localeText = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => LogoutCubit(ProfileRepoImpl(Dio())),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.read<ProfileCubit>().clearCache();
            customSnackBar(context, localeText.logoutSuccess);
            GoRouter.of(context).go(AppRouter.kLogInScreen);
          } else if (state is LogoutError) {
            customSnackBar(context, state.errorMessage);
            // GoRouter.of(context).go(AppRouter.kLogInScreen);
          }
        },
        builder: (context, state) {
          // حالة التحميل أثناء الاتصال بالسيرفر
          final bool isLoading = state is LogoutLoading;

          return Container(
            decoration: BoxDecoration(
              color: isLoading
                  ? errorColor.withOpacity(0.1)
                  : errorColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: errorColor.withOpacity(isLoading ? 0.4 : 0.2),
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: errorColor.withOpacity(0.1),
                splashColor: errorColor.withOpacity(0.1),
                onTap: isLoading
                    ? null
                    : () {
                        context.read<LogoutCubit>().logout();
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: errorColor,
                            ),
                          )
                        else
                          Icon(
                            Symbols.logout_rounded,
                            color: errorColor,
                            size: 24,
                          ),
                        const SizedBox(width: 12),
                        Text(
                          localeText.profileLogout,
                          style: AppFonts.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: errorColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
