import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_identity_item.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_section_header.dart';
import 'package:project_1/models/user.dart';

class CustomIdentityCard extends StatelessWidget {
  const CustomIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User.currentUser;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.cardShadow,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            title: 'Personal Identity',
            icon: Symbols.manage_accounts,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomIdentityItem(
                  label: 'Gender',
                  value: user.gender ?? '',
                  icon: Symbols.wc,
                ),
              ),
              Container(height: 40, width: 1, color: AppColors.greyLight),
              Expanded(
                child: CustomIdentityItem(
                  label: 'Age',
                  value: user.age.toString(),
                  icon: Symbols.cake,
                  isHighlighted: true,
                  highlightColor: AppColors.primary,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.greyLight, height: 1),
          ),
          CustomIdentityItem(
            label: 'Birthdate',
            value: user.formattedBirthdate,
            icon: Symbols.calendar_month,
          ),
        ],
      ),
    );
  }
}
