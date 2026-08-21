import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_app_bar.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_contact_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_identity_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_log_out_button.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_profile_header.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_residential_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_verifiaction_card.dart';
import 'package:project_1/models/user.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.user,
    this.onEditPressed,
    this.onLanguagePressed,
  });

  final User user;
  final VoidCallback? onEditPressed;
  final VoidCallback? onLanguagePressed;

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
                const SizedBox(height: 20),
                CustomVerificationCard(user: user),
                const SizedBox(height: 20),
                CustomResidentialCard(user: user),
                const SizedBox(height: 20),
                _buildLanguageTile(context),
                // تم تعديل الاسم هنا تزامناً مع تصحيحه
                const SizedBox(height: 30),
                const CustomLogOutButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        onTap: onLanguagePressed,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Icon(Icons.language, color: colorScheme.primary, size: 28),
        title: Text(
          localeText.profileChangeLanguage,
          style: AppFonts.bodyLarge.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          localeText.profileSelectLanguageSubtitle,
          style: AppFonts.bodyMedium.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: colorScheme.onSurface.withOpacity(0.6),
          size: 18,
        ),
      ),
    );
  }
}
