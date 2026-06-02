import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';

class CustomUploadIdPassportFile extends StatelessWidget {
  const CustomUploadIdPassportFile({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primaryDark,
        padding: const EdgeInsets.all(22),
        elevation: 0.1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Symbols.upload_file_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Text(
            "Upload id/passport Document",
            style: AppFonts.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'png'],
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          print('Picked file: ${file.name}, size: ${file.size} bytes');
        } else {
          print('user canceled the picker');
        }
      },
    );
  }
}
