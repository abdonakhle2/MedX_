import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/home/presentation/view/widgets/center_details_widget/custom_info_badge.dart';
import 'package:project_1/models/clinic.dart';

class CustomCenterDetailsHeaderImage extends StatelessWidget {
  final ClinicModel clinic;
  const CustomCenterDetailsHeaderImage({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // تنسيق وقت البداية والنهاية ليظهر بالساعات والدقائق فقط (تجاوز الثواني)
    String formatTime(String timeStr) {
      if (timeStr.length >= 5) {
        return timeStr.substring(0, 5);
      }
      return timeStr;
    }

    final String formattedStartTime = formatTime(clinic.start_time);
    final String formattedEndTime = formatTime(clinic.end_time);

    // تحديد رابط الصورة (إذا كان فارغاً نستخدم صورة افتراضية)
    final String imageUrl = clinic.logo.isNotEmpty
        ? Uri.encodeFull(clinic.logo)
        : 'https://images.unsplash.com/photo-1538108149393-fbbd81895907?auto=format&fit=crop&w=1000&q=80';

    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // عرض الصورة باستخدام Image.network مع معالجة الأخطاء
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://images.unsplash.com/photo-1538108149393-fbbd81895907?auto=format&fit=crop&w=1000&q=80',
                  fit: BoxFit.cover,
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDarkMode
                        ? Colors.black.withOpacity(0.7)
                        : Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            // محتوى معلومات العيادة (التقييم وساعات العمل)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF0F172A).withOpacity(0.4)
                      : theme.colorScheme.surface.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDarkMode
                        ? theme.colorScheme.onPrimary.withOpacity(0.08)
                        : theme.colorScheme.onPrimary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomInfoBadge(
                        value: '${clinic.rating.toStringAsFixed(1)} ⭐',
                        label: localeText.centerRating,
                      ),
                      VerticalDivider(
                        color: isDarkMode
                            ? theme.colorScheme.onPrimary.withOpacity(0.15)
                            : theme.colorScheme.onPrimary.withOpacity(0.3),
                        thickness: 1,
                        indent: 2,
                        endIndent: 2,
                      ),
                      CustomInfoBadge(
                        value: clinic.is_24h
                            ? '24/7'
                            : (formattedStartTime.isNotEmpty &&
                                  formattedEndTime.isNotEmpty)
                            ? '$formattedStartTime - $formattedEndTime'
                            : localeText.notAvailable,
                        label: localeText.centerOperatingHours,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
