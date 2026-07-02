import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
    );
  }
}
