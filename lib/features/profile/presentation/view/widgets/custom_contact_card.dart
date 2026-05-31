import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_contact_row.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_section_header.dart';

class CustomContactCard extends StatelessWidget {
  const CustomContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.cardShadow,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            title: 'Contact Information',
            icon: Symbols.contact_mail,
          ),
          const SizedBox(height: 24),
          CustomContactRow(
            icon: Symbols.mail,
            label: 'Email Address',
            value: 'JohnDoe@gmail.com',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.greyLight, height: 1),
          ),
          CustomContactRow(
            icon: Symbols.call,
            label: 'Phone Number',
            value: '+963 999 999 999',
          ),
        ],
      ),
    );
  }
}
