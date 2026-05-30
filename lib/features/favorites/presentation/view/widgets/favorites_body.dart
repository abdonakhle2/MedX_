import 'package:flutter/material.dart';
import 'package:project_1/features/favorites/presentation/view/widgets/custom_app_bar.dart';

import 'package:project_1/widgets/card_clinic.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          const CustomAppBar(),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CardClinic();
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}
