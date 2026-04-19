import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/screens/department_screen.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class CenterDetailsScreen extends StatefulWidget {
  const CenterDetailsScreen({super.key});

  @override
  State<CenterDetailsScreen> createState() => _CenterDetailsScreenState();
}

class _CenterDetailsScreenState extends State<CenterDetailsScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
      appBar: AppBar(
        title: Text(
          'MedX',
          style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildHeaderImage(),
          SizedBox(height: 20),
          buildAboutSection(),
          SizedBox(height: 20),
          buildLocationSection(),
          SizedBox(height: 20),
          Text(
            "   Clinical Departments :",
            style: AppFonts.headlineMedium.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return buildDepartmentCard(
                Icon(Symbols.dentistry),
                Symbols.dentistry,
                "Department 1",

                context,
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget buildHeaderImage() {
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[300],
      image: DecorationImage(
        image: NetworkImage(
          "https://images.unsplash.com/photo-1588776814546-9b1c8e5f0a3c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG9zcGl0YWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
        ),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("4.5 ⭐", style: TextStyle(color: Colors.white)),
                  Text(
                    "EXPERIENCE",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("8 AM - 8 PM", style: TextStyle(color: Colors.white)),
                  Text(
                    "OPERATING HOURS",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildAboutSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFEEF2FF),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About the Institute",
          style: AppFonts.headlineLarge.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 10),
        Text(
          "At Harborview, we redefine clinical excellence through an editorial lens. Our facility combines state-of-the-art diagnostic technology...",
          style: AppFonts.bodyLarge.copyWith(color: AppColors.greyMedium),
        ),
      ],
    ),
  );
}

Widget buildLocationSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: AppColors.greyLight, spreadRadius: 2, blurRadius: 10),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: AppColors.white, size: 30),
        Text(
          "Location",
          style: AppFonts.bodyLarge.copyWith(color: AppColors.white),
        ),
        Text(
          "4221 Medical District Plaza, WA 98101",
          style: AppFonts.bodyLarge.copyWith(color: AppColors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            minimumSize: const Size(double.infinity, 45),
          ),
          child: Text(
            "GET DIRECTIONS",
            style: AppFonts.bodyLarge.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    ),
  );
}

Widget buildDepartmentCard(
  Icon icon1,
  IconData icon,
  String title,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DepartmentScreen(Category: title),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,

      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withOpacity(0.08),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          SizedBox(height: 40),
          Text(
            title,
            style: AppFonts.headlineSmall.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    ),
  );
}
