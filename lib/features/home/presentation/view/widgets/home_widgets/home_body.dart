import 'package:flutter/material.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_header.dart';
import 'package:project_1/features/home/presentation/view/widgets/home_widgets/custom_home_centers.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          const CustomHomeHeader(),
          SliverToBoxAdapter(
            child: Column(
              children: const [SizedBox(height: 20), CustomHomeCenters()],
            ),
          ),
        ],
      ),
    );
  }
}
