import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/widgets/bottom_nav_bar.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo_imp.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_language_dialog.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileRepo = ProfileRepoImpl(Dio());
    return BlocProvider(
      create: (context) => UpdateCubit(profileRepo),
      child: const _ProfileScreenView(),
    );
  }
}

class _ProfileScreenView extends StatefulWidget {
  const _ProfileScreenView();

  @override
  State<_ProfileScreenView> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreenView> {
  final int _navIndex = 4;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    final routes = [
      AppRouter.kHomeScreen,
      AppRouter.kFavoritesScreen,
      AppRouter.kSearchScreen,
      AppRouter.kBookingScreen,
      AppRouter.kProfileScreen,
    ];
    // Navigator.pushReplacementNamed(context, routes[index]);
    GoRouter.of(context).pushReplacement(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
        ),
        body: ProfileBody(
          onLanguagePressed: () => CustomLanguageDialog(context),
        ),
      ),
    );
  }
}
