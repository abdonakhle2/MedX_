import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/utils/function/launch_url.dart';

class CustomCenterDetailsLocation extends StatelessWidget {
  const CustomCenterDetailsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.headerGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.elevatedShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Location',
                style: AppFonts.headlineSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '4221 Medical District Plaza, WA 98101',
            style: AppFonts.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.85),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _openGoogleMaps(
                  latitude: 47.6062,
                  longitude: -122.3321,
                  context: context,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'GET DIRECTIONS',
                    style: AppFonts.labelLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openGoogleMaps({
    required double latitude,
    required double longitude,
    required BuildContext context,
  }) async {
    try {
      // final Uri webUrl = Uri.parse(
      //   'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      // );
      // if (await canLaunchUrl(webUrl)) {
      //   await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      // }
      launchCustomer(
        url:
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
        context: context,
      );
    } catch (_) {}
  }
}
