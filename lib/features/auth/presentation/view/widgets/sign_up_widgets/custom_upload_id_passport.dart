import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart' show AppFonts;
import 'package:project_1/core/localization/l10n/app_localizations.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomUploadIdPassportFile extends StatefulWidget {
  final PlatformFile? selectedFile;
  final ValueChanged<PlatformFile?>? onFileSelected;
  final String? errorText;

  const CustomUploadIdPassportFile({
    super.key,
    this.selectedFile,
    this.onFileSelected,
    this.errorText,
  });

  @override
  State<CustomUploadIdPassportFile> createState() =>
      _CustomUploadIdPassportFileState();
}

class _CustomUploadIdPassportFileState
    extends State<CustomUploadIdPassportFile> {
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
      debugPrint("Error picking file: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeText = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickPassportImage,
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.errorText != null
                    ? colorScheme.error
                    : colorScheme.onSurface.withOpacity(0.15),
                style: BorderStyle.solid,
                width: 1.5,
              ),
            ),
            child: widget.selectedFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        _buildFilePreview(widget.selectedFile!),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              widget.onFileSelected?.call(null);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: colorScheme.error.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Symbols.cloud_upload_rounded,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        localeText.registerUploadIDPassport,
                        style: AppFonts.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localeText.registerSupportedFormats,
                        style: AppFonts.labelSmall.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.4),
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
        color: colorScheme.onSurface.withOpacity(0.08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.insert_drive_file_rounded, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(file.name, style: TextStyle(color: colorScheme.onSurface)),
          ],
        ),
      );
    }
  }
}
