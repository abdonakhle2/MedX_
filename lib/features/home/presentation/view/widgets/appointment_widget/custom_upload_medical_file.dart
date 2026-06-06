import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart'
    show AppFonts, AppColors, AppShadows;
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
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to pick image: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFile = widget.selectedFile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickPassportImage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.errorText != null
                    ? Colors.red.shade700
                    : AppColors.primary.withOpacity(0.25),
                width: 1.2,
              ),
              boxShadow: AppShadows.cardShadow,
            ),
            child: selectedFile == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Symbols.upload_file_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload a clear passport photo',
                              style: AppFonts.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Tap to choose a passport image (JPG or PNG)',
                              style: AppFonts.bodyMedium.copyWith(
                                color: AppColors.secondary,
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
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Passport image selected. Tap to change.',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _pickPassportImage,
                          child: Text(
                            'Change',
                            style: AppFonts.bodyLarge.copyWith(
                              color: AppColors.primary,
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
              color: Colors.red.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilePreview(PlatformFile file) {
    final extension = file.extension?.toLowerCase();

    if (extension == 'pdf') {
      // 📄 عرض ملف الـ PDF من الذاكرة مباشرة
      return SfPdfViewer.memory(
        file.bytes!,
        canShowScrollHead: false,
        canShowScrollStatus: false,
      );
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png') {
      // 🖼️ عرض الصورة كالمعتاد
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      // في حال رفع صيغة أخرى غير مدعومة للعرض المباشر
      return Container(
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.insert_drive_file,
              color: Colors.blueGrey,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text('ملف مدعوم: ${file.name}'),
          ],
        ),
      );
    }
  }
}
