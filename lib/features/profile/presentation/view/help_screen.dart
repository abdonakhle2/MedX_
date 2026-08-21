import 'package:flutter/material.dart';
import 'package:project_1/features/profile/presentation/view/widgets/help_widgets/help_app_bar.dart';
import 'package:project_1/features/profile/presentation/view/widgets/help_widgets/help_body.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HelpAppBar(),
      body: HelpBody(),
    );
  }
}
