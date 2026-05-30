import 'package:flutter/material.dart';
import 'package:project_1/features/auth/presentation/view/widgets/log_in_widgets/build_footer_item.dart';

class CustomLogInTail extends StatelessWidget {
  const CustomLogInTail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildFooterItem(
            icon: Icons.verified_user_rounded,
            label: 'HIPAA COMPLIANT',
          ),
          Container(width: 1, height: 16, color: Colors.grey.shade300),
          BuildFooterItem(icon: Icons.lock_rounded, label: '256-BIT AES'),
        ],
      ),
    );
  }
}
