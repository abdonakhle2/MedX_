import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:project_1/constants/constants.dart';
import 'package:project_1/widgets/bottom_nav_bar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

bool isPending = true;

class _BookingScreenState extends State<BookingScreen> {
  int _navIndex = 2;

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
          style: AppFonts.headlineLarge.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildTextHeader(),
          SizedBox(height: 30),
          buildBodyButton(),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return buildBodyScreen();
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color.fromARGB(255, 243, 242, 242),
            ),
            child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'View Older Bookings',
                    style: AppFonts.bodyLarge.copyWith(color: AppColors.black),
                  ),
                  Icon(Symbols.arrow_downward_sharp, color: AppColors.black),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Container buildBodyScreen() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.vertical(
                  top: Radius.circular(20),
                ),
                child: Icon(Symbols.person_filled_rounded, size: 300),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'CARDOILOGY',
                    style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Symbols.calendar_today,
                      size: 35,
                      color: AppColors.primary,
                    ),
                    Column(
                      children: [
                        Text(
                          'Date',
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                        Text('oct 24,2023'),
                      ],
                    ),
                    SizedBox(width: 50),
                    Icon(
                      Symbols.access_time,
                      size: 35,
                      color: AppColors.primary,
                    ),
                    Column(
                      children: [
                        Text(
                          'Time',
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                        Text('10:30 AM'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyLight,
                      foregroundColor: AppColors.black,
                    ),
                    onPressed: () {},
                    child: Text("Reschedule"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.error.withOpacity(0.4)),
                      foregroundColor: AppColors.error,
                    ),
                    onPressed: () {},
                    child: Text(
                      textAlign: TextAlign.center,
                      "Cancel\n Appointment",
                      style: AppFonts.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildBodyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              isPending = true;
            });
          },
          child: Column(
            children: [
              Text(
                'Pending',
                style: AppFonts.headlineLarge.copyWith(
                  fontSize: 20,

                  color: isPending ? AppColors.primary : AppColors.greyMedium,
                ),
              ),
              (isPending)
                  ? Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.primary,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isPending = false;
            });
          },
          child: Column(
            children: [
              Text(
                'Completed',
                style: AppFonts.headlineLarge.copyWith(
                  fontSize: 20,
                  color: (isPending == false)
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
              ),
              (isPending == false)
                  ? Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.primary,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildTextHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'My Bookings',
        style: AppFonts.headlineExtraLarge.copyWith(color: AppColors.black),
      ),
      SizedBox(height: 10),
      Text(
        'Manage your upcoming journeys and review past clinical visits .',
        style: AppFonts.bodyMedium.copyWith(color: AppColors.secondary),
      ),
    ],
  );
}
