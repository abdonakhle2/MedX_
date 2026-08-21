import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClinic extends StatelessWidget {
  const ShimmerClinic({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20, width: 100, color: Colors.white),
                    const SizedBox(height: 14),
                    Container(height: 20, width: 200, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 15, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 16),
                    Container(height: 1, color: Colors.white),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(height: 32, width: 32, color: Colors.white),
                        const SizedBox(width: 10),
                        Container(height: 15, width: 120, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
