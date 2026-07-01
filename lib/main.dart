import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/theme/cubit/theme_cubit.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';

void main() {
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => FavoritesCubit()..loadFavorites()),
        BlocProvider(create: (context) => ProfileCubit()..loadProfile()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,

            themeMode: themeMode,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor:
                  AppColors.neutral, // استخدام لونك الخاص بالخلفية

              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                secondary: AppColors.secondary,
                surface: AppColors.cardBg,
                error: AppColors.error,
              ),

              // تطبيق الخطوط الخاصة بك للوضع الفاتح
              textTheme: TextTheme(
                headlineLarge: AppFonts.headlineLarge.copyWith(
                  color: AppColors.black,
                ),
                headlineMedium: AppFonts.headlineMedium.copyWith(
                  color: AppColors.black,
                ),
                headlineSmall: AppFonts.headlineSmall.copyWith(
                  color: AppColors.black,
                ),
                bodyLarge: AppFonts.bodyLarge.copyWith(color: AppColors.black),
                bodyMedium: AppFonts.bodyMedium.copyWith(
                  color: AppColors.greyMedium,
                ),
                bodySmall: AppFonts.bodySmall.copyWith(color: AppColors.grey),
              ),

              // تطبيق ثيم الكارد الفاتح مع ظلالك الخاصة
              cardTheme: CardThemeData(
                color: AppColors.cardBg,
                elevation:
                    0, // نعتمد على الـ BoxShadow الخاص بك يدويًا أو هنا كـ الارتفاع الأساسي
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.black,
                elevation: 0,
              ),
            ),

            // ==================== 2. الوضع الداكن (Dark Theme) ====================
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(
                0xFF0F172A,
              ), // خلفية داكنة متناسقة مع درجات الأزرق والرمادي لديك

              colorScheme: const ColorScheme.dark(
                primary: AppColors
                    .primaryLight, // نستخدم الدرجة الفاتحة كعنصر مضيء في الداكن
                secondary: AppColors.secondary,
                surface: const Color(0xFF1E293B), // كارد داكن متناسق
                error: AppColors.error,
              ),

              // تطبيق الخطوط للوضع الداكن (مع تحويل النصوص للأبيض)
              textTheme: TextTheme(
                headlineLarge: AppFonts.headlineLarge.copyWith(
                  color: AppColors.white,
                ),
                headlineMedium: AppFonts.headlineMedium.copyWith(
                  color: AppColors.white,
                ),
                headlineSmall: AppFonts.headlineSmall.copyWith(
                  color: AppColors.white,
                ),
                bodyLarge: AppFonts.bodyLarge.copyWith(color: AppColors.white),
                bodyMedium: AppFonts.bodyMedium.copyWith(
                  color: const Color(0xFF94A3B8),
                ),
                bodySmall: AppFonts.bodySmall.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),

              cardTheme: CardThemeData(
                color: const Color(0xFF1E293B),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF0F172A),
                foregroundColor: AppColors.white,
                elevation: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
