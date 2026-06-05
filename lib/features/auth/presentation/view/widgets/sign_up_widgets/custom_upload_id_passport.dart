import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';

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
        type: FileType.image,
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
                          child: Image.memory(
                            selectedFile.bytes!,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
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
}
