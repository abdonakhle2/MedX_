import 'package:flutter/material.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/help_widgets/help_section_item.dart';

class HelpBody extends StatelessWidget {
  const HelpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          HelpSectionItem(
            title: localeText.helpHowToBookTitle,
            description: localeText.helpHowToBookDesc,
            icon: Icons.calendar_today_rounded,
          ),
          HelpSectionItem(
            title: localeText.helpReviewBookingTitle,
            description: localeText.helpReviewBookingDesc,
            icon: Icons.receipt_long_rounded,
          ),
          HelpSectionItem(
            title: localeText.helpRescheduleTitle,
            description: localeText.helpRescheduleDesc,
            icon: Icons.edit_calendar_rounded,
          ),
          HelpSectionItem(
            title: localeText.helpBookingDetailsTitle,
            description: localeText.helpBookingDetailsDesc,
            icon: Icons.assignment_rounded,
          ),
          HelpSectionItem(
            title: localeText.helpManageFavoritesTitle,
            description: localeText.helpManageFavoritesDesc,
            icon: Icons.favorite_border_rounded,
          ),
          HelpSectionItem(
            title: localeText.helpAppInfoTitle,
            description: localeText.helpAppInfoDesc,
            icon: Icons.info_outline_rounded,
          ),
          // HelpSectionItem(
          //   title: localeText.helpContactSupportTitle,
          //   description: localeText.helpContactSupportDesc,
          //   icon: Icons.support_agent_rounded,
          // ),
        ],
      ),
    );
  }
}
