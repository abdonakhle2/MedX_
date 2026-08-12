import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/custom_input_decoration.dart';

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({super.key, required this.emailController});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: emailController,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.emailAddress,
      style: AppFonts.bodyMedium.copyWith(color: colorScheme.onSurface),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return localeText.emailRequiredLogin;
        }
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value.trim())) {
          return localeText.emailInvalidLogin;
        }
        return null;
      },
      decoration: buildInputDecoration(
        context: context,
        hintText: 'JohnDoe@gmail.com',
        icon: Symbols.mail,
      ),
    );
  }
}
