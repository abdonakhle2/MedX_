import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomRatingStars extends StatefulWidget {
  final ValueChanged<double> onRatingChanged; // إضافة متغير لإرسال القيمة

  const CustomRatingStars({super.key, required this.onRatingChanged});

  @override
  State<CustomRatingStars> createState() => _CustomRatingStarsState();
}

class _CustomRatingStarsState extends State<CustomRatingStars> {
  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedStars = index + 1;
              });
              widget.onRatingChanged(
                _selectedStars.toDouble(),
              ); // إرسال القيمة عند الضغط
            },
            child: Icon(
              index < _selectedStars
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              color: AppColors.amber,
              size: 36,
            ),
          ),
        );
      }),
    );
  }
}
