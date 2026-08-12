import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/core/widgets/auth_app_bar.dart';
import 'package:project_1/features/auth/data/repo/log_in_repo/log_in_repo_impl.dart';
import 'package:project_1/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/log_in_body.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        LoginRepoImpl(
          Dio(), // إنشاء كائن Dio مباشرةً أو استخدام ApiService الخاص بك
        ),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AuthAppBar(),
              Expanded(child: LogInBody()),
            ],
          ),
        ),
      ),
    );
  }
}
