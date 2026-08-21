import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_search_app_bar.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_result_search_list.dart';
import 'package:project_1/features/search/presentation/view/widgets/custom_search_bar.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // جلب العيادات فقط بدلاً من الأطباء
      context.read<HomeCubit>().fetchClinics();
    });
  }

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
                CustomSearchBar(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                // عرض نتائج البحث الخاصة بالمراكز فقط
                CustomResultSearchList(searchQuery: searchQuery),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
