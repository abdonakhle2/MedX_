import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';

class CustomAddNote extends StatelessWidget {
  const CustomAddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Symbols.note_alt,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Consultation Notes',
                style: AppFonts.headlineSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Mention any specific symptoms, medical history, or concerns you wish to discuss during the session.',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.secondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: TextField(
              cursorColor: AppColors.primary,
              maxLines: 5,
              style: AppFonts.bodyMedium,
              decoration: InputDecoration(
                filled: false,
                hintText: 'Type your notes here...',
                hintStyle: AppFonts.bodyMedium.copyWith(
                  color: AppColors.secondary.withOpacity(0.4),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
