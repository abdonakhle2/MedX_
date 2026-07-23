import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart' show AppFonts, AppShadows;
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomUploadMedicalFile extends StatefulWidget {
  final PlatformFile? selectedFile;
  final ValueChanged<PlatformFile?>? onFileSelected;
  final String? errorText;
  const CustomUploadMedicalFile({
    super.key,
    this.selectedFile,
    this.onFileSelected,
    this.errorText,
  });

  @override
  State<CustomUploadMedicalFile> createState() =>
      _CustomUploadMedicalFileState();
}

class _CustomUploadMedicalFileState extends State<CustomUploadMedicalFile> {
  Future<void> _pickPassportImage() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        widget.onFileSelected?.call(result.files.first);
      }
    } catch (error) {
      final localeText = AppLocalizations.of(context)!;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${localeText.medicalUploadError} $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final selectedFile = widget.selectedFile;
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickPassportImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.errorText != null
                    ? colorScheme.error
                    : colorScheme.primary.withOpacity(0.25),
                width: 1.2,
              ),
              boxShadow: isDarkMode ? [] : AppShadows.cardShadow,
            ),
            child: selectedFile == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Symbols.upload_file_rounded,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localeText.medicalUploadTapToUpload,
                              style: AppFonts.labelLarge.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedFile.bytes != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _buildFilePreview(selectedFile),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        selectedFile.name,
                        style: AppFonts.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        localeText.medicalUploadFileSelected,
                        style: AppFonts.bodyMedium.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _pickPassportImage,
                          child: Text(
                            localeText.medicalUploadChange,
                            style: AppFonts.bodyLarge.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: AppFonts.bodySmall.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilePreview(PlatformFile file) {
    final colorScheme = Theme.of(context).colorScheme;
    final extension = file.extension?.toLowerCase();

    if (extension == 'pdf') {
      return SfPdfViewer.memory(
        file.bytes!,
        canShowScrollHead: false,
        canShowScrollStatus: false,
      );
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        color: colorScheme.onSurface.withOpacity(0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_drive_file,
              color: colorScheme.onSurface.withOpacity(0.4),
              size: 30,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                file.name,
                style: TextStyle(color: colorScheme.onSurface),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
  }
}
