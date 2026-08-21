import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_1/core/localization/cubit/loacale_cubit.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/theme/cubit/theme_cubit.dart';
import 'package:project_1/core/utils/app_router.dart';
import 'package:project_1/core/utils/function/locale_notifications_service.dart';
import 'package:project_1/features/booking/data/booking_repo_imp.dart';
import 'package:project_1/features/booking/presentation/manager/appointment_cubit/user_appoinment_cubit.dart';
import 'package:project_1/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo_impl.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:project_1/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:project_1/features/notifications/presentation/manager/cubit/notifications_cubit.dart';
import 'package:project_1/features/profile/data/repos/profile_repo/profile_repo_imp.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("تم استقبال إشعار في الخلفية: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1. تهيئة الإشعارات المحلية
  LocalNotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();

  String? fcmToken;
  try {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
  } catch (e) {
    print("خطأ في جلب التوكن: $e");
  }

  const secureStorage = FlutterSecureStorage();
  String? token = await secureStorage.read(key: 'auth_token');
  bool isLoggedIn = token != null && token.isNotEmpty;

  if (isLoggedIn && fcmToken != null) {
    try {
      await NotificationsRepoImpl(Dio()).sendFcmToken(fcmToken);
    } catch (e) {
      print("خطأ في إرسال الـ FCM Token: $e");
    }
  }

  // 2. تفعيل ظهور الإشعار المنبثق مع الصوت أثناء فتح التطبيق
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
      'تم استلام إشعار في الواجهة الأمامية: ${message.notification?.title}',
    );
    LocalNotificationService.showNotification(message);
  });

  AppRouter.setupRouter(isLoggedIn);
  runApp(const TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
          create: (context) => FavoritesCubit(FavoritesRepoImpl(Dio())),
        ),
        BlocProvider(create: (context) => HomeCubit(HomeRepoImpl(Dio()))),
        BlocProvider(create: (context) => ProfileCubit(ProfileRepoImpl(Dio()))),
        BlocProvider(
          create: (context) => UserAppointmentsCubit(BookingRepoImpl(Dio())),
        ),
        BlocProvider(
          create: (context) => NotificationsCubit(NotificationsRepoImpl(Dio())),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, currentLocale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
                routerConfig: AppRouter.router,
                themeMode: themeMode,

                // 🟢 إعدادات التوطين واللغة المربوطة بالـ Cubit
                locale: currentLocale,
                localizationsDelegates: const [
                  AppLocalizations
                      .delegate, // الكلاس المولد من ملف app_localizations.dart
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                theme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: AppColors.neutral,

                  colorScheme: const ColorScheme.light(
                    primary: AppColors.primary,
                    secondary: AppColors.secondary,
                    surface: AppColors.cardBg, // لون الأسطح والكروت الافتراضي
                    error: AppColors.error,
                    onPrimary: AppColors.white,
                    onSurface: AppColors.black, // لون النصوص فوق الأسطح
                  ),

                  // ثيم النصوص (Text Theme)
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
                    bodyLarge: AppFonts.bodyLarge.copyWith(
                      color: AppColors.black,
                    ),
                    bodyMedium: AppFonts.bodyMedium.copyWith(
                      color: AppColors.greyMedium,
                    ),
                    bodySmall: AppFonts.bodySmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),

                  // ثيم الكروت (Card Theme)
                  cardTheme: CardThemeData(
                    color: AppColors.cardBg,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // ثيم حقول الإدخال (TextField / InputDecoration Theme)
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: AppColors.white, // خلفية الحقل في الوضع الفاتح
                    hintStyle: AppFonts.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                    prefixIconColor: AppColors.greyMedium,
                    suffixIconColor: AppColors.greyMedium,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xE2E8F0),
                      ), // رمادي خفيف جداً
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),

                  // ثيم الأزرار (ElevatedButton Theme)
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: AppFonts.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // ثيم القوائم (ListTile Theme)
                  listTileTheme: const ListTileThemeData(
                    iconColor: AppColors.primary,
                    textColor: AppColors.black,
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
                  ), // خلفية داكنة مريحة للعين

                  colorScheme: const ColorScheme.dark(
                    primary:
                        AppColors.primaryLight, // اللون المضيء في الوضع الداكن
                    secondary: AppColors.secondary,
                    surface: Color(
                      0xFF1E293B,
                    ), // خلفية الكروت والأسطح في الداكن
                    error: AppColors.error,
                    onPrimary: AppColors.black,
                    onSurface: AppColors.white, // لون النصوص فوق الأسطح الداكنة
                  ),

                  // ثيم النصوص (Text Theme) للوضع الداكن
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
                    bodyLarge: AppFonts.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                    bodyMedium: AppFonts.bodyMedium.copyWith(
                      color: const Color(0xFF94A3B8),
                    ),
                    bodySmall: AppFonts.bodySmall.copyWith(
                      color: const Color(0xFF64748B),
                    ),
                  ),

                  // ثيم الكروت (Card Theme) للوضع الداكن
                  cardTheme: CardThemeData(
                    color: const Color(0xFF1E293B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // ثيم حقول الإدخال (TextField) للوضع الداكن
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: const Color(
                      0xFF1E293B,
                    ), // نفس لون الكارد الداكن أو أغمق قليلاً
                    hintStyle: AppFonts.bodyMedium.copyWith(
                      color: const Color(0xFF64748B),
                    ),
                    prefixIconColor: const Color(0xFF94A3B8),
                    suffixIconColor: const Color(0xFF94A3B8),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF334155),
                      ), // حدود داكنة متناسقة
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primaryLight,
                        width: 1.5,
                      ),
                    ),
                  ),

                  // ثيم الأزرار (ElevatedButton Theme) للوضع الداكن
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors
                          .primary, // يمكنك استخدام primaryLight إن أردت زر مضيء
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: AppFonts.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // ثيم القوائم (ListTile Theme) للوضع الداكن
                  listTileTheme: const ListTileThemeData(
                    iconColor: AppColors.primaryLight,
                    textColor: AppColors.white,
                  ),

                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF0F172A),
                    foregroundColor: AppColors.white,
                    elevation: 0,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
