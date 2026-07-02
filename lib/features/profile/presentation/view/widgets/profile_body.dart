import 'package:flutter/material.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_app_bar.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_contact_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_identity_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_log_out_button.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_profile_header.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_residential_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_verifiaction_card.dart';
import 'package:project_1/models/user.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user, this.onEditPressed});

  final User user;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar(onEditPressed: onEditPressed),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomProfileHeader(user: user),
                const SizedBox(height: 30),
                CustomContactCard(user: user),
                const SizedBox(height: 20),
                CustomIdentityCard(user: user),
                const SizedBox(height: 30),
                CustomResidentialCard(user: user),
                const SizedBox(height: 20),
                const CustomVerificationCard(), // تم تعديل الاسم هنا تزامناً مع تصحيحه
                const SizedBox(height: 30),
                const CustomLogOutButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
