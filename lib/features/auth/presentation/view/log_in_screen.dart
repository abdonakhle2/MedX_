import 'package:flutter/material.dart';
import 'package:project_1/core/widgets/auth_app_bar.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/log_in_body.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            AuthAppBar(),
            Expanded(child: LogInBody()),
          ],
        ),
      ),
    );
  }
}
