import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:project_1/features/profile/presentation/manager/cubit/update_cubit.dart';
import 'package:project_1/features/profile/presentation/view/widgets/edit_profile_widgets/edit_profile_verification_dialog.dart';
import 'package:project_1/features/profile/presentation/view/widgets/profile_widgets/custom_section_header.dart';
import 'package:project_1/models/user.dart';

class CustomVerificationCard extends StatelessWidget {
  const CustomVerificationCard({super.key, required this.user});
  final User user;

  // Helper method to get the correct image URL
  String _getImageUrl(String fileName) {
    if (fileName.startsWith('http')) return fileName;
    String path = fileName.startsWith('/') ? fileName.substring(1) : fileName;

    // قم بتغيير هذا المسار إذا كان السيرفر يحفظ الصور في مجلد فرعي مثل 'uploads' أو 'passports'
    // مثال: return 'https://medx.sy/storage/uploads/$path';

    final fullUrl = 'https://medx.sy/storage/$path';
    print(
      "Generated Image URL: $fullUrl",
    ); // راقب هذا الرابط في الـ Debug Console
    return fullUrl;
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.06),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSectionHeader(
                title: localeText.profileVerificationDocuments,
                icon: Symbols.verified,
              ),
              IconButton(
                onPressed: () => _showEditVerificationDialog(context),
                icon: Icon(Symbols.edit, color: colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localeText.profilePassportFile,
                      style: AppFonts.labelSmall.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.4),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (user.idPassport != null &&
                        user.idPassport.toString().trim().isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: user.idPassport is File
                            ? Image.file(
                                user.idPassport as File,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(
                                    Icons.image_not_supported_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Image.network(
                                _getImageUrl(user.idPassport.toString()),
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 120,
                                        width: double.infinity,
                                        color: colorScheme.onSurface
                                            .withOpacity(0.05),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint("Error loading image: $error");
                                  return Container(
                                    height: 120,
                                    width: double.infinity,
                                    color: colorScheme.onSurface.withOpacity(
                                      0.05,
                                    ),
                                    child: const Icon(
                                      Icons.image_not_supported_rounded,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                      )
                    else
                      Text(
                        localeText.profileNoPassportImage,
                        style: AppFonts.bodyLarge.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Symbols.visibility,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<UpdateCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
        ],
        child: EditProfileVerificationDialog(user: user),
      ),
    );
  }
}
