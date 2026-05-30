import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

class CustomRatingStars extends StatefulWidget {
  const CustomRatingStars({super.key});

  @override
  State<CustomRatingStars> createState() => _CustomRatingStarsState();
}

class _CustomRatingStarsState extends State<CustomRatingStars> {
  int _selectedStars = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedStars = index + 1;
              });
            },
            child: Icon(
              index < _selectedStars
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              color: AppColors.amber,
              size: 32,
            ),
          ),
        );
      }),
    );
  }
}
