import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/core/utils/app_router.dart';

class CustomLogOutButton extends StatelessWidget {
  const CustomLogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final errorColor = colorScheme.error;
    final localeText = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: errorColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: errorColor.withOpacity(0.2), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          highlightColor: errorColor.withOpacity(0.1),
          splashColor: errorColor.withOpacity(0.1),
          onTap: () async {
            const secureStorage = FlutterSecureStorage();

            // 3. حذف التوكن المخزن لتسجيل الخروج فعلياً
            await secureStorage.delete(key: 'auth_token');
            if (context.mounted) {
              context.go(AppRouter.kLogInScreen);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Symbols.logout_rounded, color: errorColor, size: 24),
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
  }
}
