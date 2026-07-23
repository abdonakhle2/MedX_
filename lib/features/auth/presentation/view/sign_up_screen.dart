import 'package:flutter/material.dart';
import 'package:project_1/core/widgets/auth_app_bar.dart';
import 'package:project_1/features/auth/presentation/view/widgets/sign_up_widgets/sign_up_body.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            AuthAppBar(),
            Expanded(child: SignUpBody()),
          ],
        ),
      ),
    );
  }
}
