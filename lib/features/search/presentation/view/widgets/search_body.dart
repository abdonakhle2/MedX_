import 'package:flutter/material.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_app_bar.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_body_button.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_result_search_list.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_search_bar.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  bool isCenter = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSearchAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                CustomSearchBar(),
                // Search bar
                const SizedBox(height: 20),

                CustomBodyButton(
                  isCenter: isCenter,
                  onChanged: (value) {
                    setState(() {
                      isCenter = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                // Search results
                CustomResultSearchList(isCenter: isCenter),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
