import 'package:flutter/material.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_app_bar.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_contact_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_identity_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_log_out_button.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_profile_header.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_residential_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/custom_verifiaction_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, this.onEditPressed});

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
                const CustomProfileHeader(),
                const SizedBox(height: 30),
                const CustomContactCard(),
                const SizedBox(height: 20),
                const CustomIdentityCard(),
                const SizedBox(height: 30),
                const CustomResidentialCard(),
                const SizedBox(height: 20),
                const CustomVerifiactionCard(),
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
