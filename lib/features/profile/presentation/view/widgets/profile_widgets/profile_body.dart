import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_profile_app_bar.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_state.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_contact_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_identity_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_log_out_button.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_profile_header.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_residential_card.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_verifiaction_card.dart';
import 'package:project_1/features/profile/presentation/view/help_screen.dart';
import 'package:project_1/core/widgets/custom_error_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, this.onLanguagePressed});

  final VoidCallback? onLanguagePressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is ProfileLoading)
                      _buildShimmer(context)
                    else if (state is ProfileError)
                      _buildErrorWidget(context, state.errorMessage)
                    else if (state is ProfileLoaded)
                      Column(
                        children: [
                          CustomProfileHeader(user: state.user),
                          const SizedBox(height: 30),
                          CustomContactCard(user: state.user),
                          const SizedBox(height: 20),
                          CustomIdentityCard(user: state.user),
                          const SizedBox(height: 20),
                          CustomVerificationCard(user: state.user),
                          const SizedBox(height: 20),
                          CustomResidentialCard(user: state.user),
                        ],
                      ),
                    const SizedBox(height: 20),
                    _buildLanguageTile(context),
                    const SizedBox(height: 20),
                    _buildHelpTile(context),
                    const SizedBox(height: 30),
                    const CustomLogOutButton(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 24, width: 150, color: Colors.white),
          const SizedBox(height: 30),
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String errorMessage) {
    return CustomErrorWidget(
      errorMessage: errorMessage,
      onRetry: () {
        context.read<ProfileCubit>().loadProfile();
      },
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

  Widget _buildHelpTile(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpScreen()),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Icon(
          Icons.help_outline_rounded,
          color: colorScheme.primary,
          size: 28,
        ),
        title: Text(
          localeText.profileHelpCenter,
          style: AppFonts.bodyLarge.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          localeText.profileHelpCenterSubtitle,
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
