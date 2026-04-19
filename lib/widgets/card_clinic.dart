import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/screens/center_details_screen.dart';

class CardClinic extends StatelessWidget {
  const CardClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. قسم الصورة (يجب وضع رابط صورة حقيقي أو Asset)
            Container(
              height: 180,
              width: double.infinity,
              color: Colors.blueGrey[100], // خلفية مؤقتة
              child: const Icon(
                Symbols.airline_seat_individual_suite,
                size: 50,
                color: Colors.white,
              ),
              // استبدله بـ Image.network أو Image.asset
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. التاج والتقييم
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.tertiary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'PRIMARY FACILITY',
                          style: AppFonts.labelSmall.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const Text(
                        " 4.9",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 3. اسم المستشفى
                  Text(
                    "City General Hospital",
                    style: AppFonts.headlineSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 4. الوصف
                  Text(
                    "A cornerstone of regional health, providing comprehensive emergency care, surgery, and advanced diagnostics.",
                    style: AppFonts.bodySmall.copyWith(
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),

                  const Divider(height: 30),

                  // 5. المسافة والزر
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const Text(
                        " 1.2 miles away",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CenterDetailsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
