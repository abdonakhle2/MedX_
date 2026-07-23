import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_1/core/utils/app_router.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back),
          color: colorScheme.primary,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.push(AppRouter.kSplashScreen);
            }
          },
        ),
        // const SizedBox(width: 12),
        // Container(
        //   padding: const EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     color: colorScheme.primary,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Icon(
        //     Icons.local_hospital_rounded,
        //     color: colorScheme.onPrimary,
        //     size: 18,
        //   ),
        // ),
        // const SizedBox(width: 10),
        // Text(
        //   'MedX',
        //   style: AppFonts.headlineMedium.copyWith(
        //     color: colorScheme.primary,
        //     fontWeight: FontWeight.w800,
        //     letterSpacing: -0.5,
        //   ),
        // ),
      ],
    );
  }
}
