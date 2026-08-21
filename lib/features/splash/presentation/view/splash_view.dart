import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/auth/data/repo/log_in_repo/log_in_repo_impl.dart';
import 'package:project_1/features/splash/presentation/view/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // 1. إنشاء instance من الـ Repo
    final loginRepo = LoginRepoImpl(Dio());

    // 2. التحقق فوراً من حالة التوكن
    bool isLoggedIn = await loginRepo.isUserLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      // إذا كان مسجلاً، انتقل فوراً للرئيسية دون انتظار
      context.go(AppRouter.kHomeScreen);
    } else {
      // إذا لم يكن مسجلاً، انتظر 3 ثوانٍ (لإتمام الـ Animation)
      // ثم ابقَ في الشاشة (لا تقم بعمل Go Router) ليتمكن المستخدم من اختيار اللغة
      await Future.delayed(const Duration(seconds: 3));

      // لا توجد عملية تنقل هنا، المستخدم سيظل أمام SplashViewBody
      debugPrint("User is not logged in, staying on SplashViewBody");
    }
  }

  @override
  Widget build(BuildContext context) {
    // نقوم بعرض الواجهة التي تحتوي على الشعار والـ Animation واختيار اللغة
    return const Scaffold(body: SplashViewBody());
  }
}
