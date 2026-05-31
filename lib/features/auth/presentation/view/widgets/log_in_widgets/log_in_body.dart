import 'package:flutter/material.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_head_line.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_head_text.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_log_in_body.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/custom_log_in_tail.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Image.asset('assets/images/logo.png', width: 150, height: 150),
              const CustomHeadText(),
              const SizedBox(height: 8),
              const CustomHeadLine(),
              const SizedBox(height: 20),
              // Main Card
              const CustomLogInBody(),
              const SizedBox(height: 24),
              // Footer
              const CustomLogInTail(),
            ],
          ),
        ),
      ),
    );
  }
}
