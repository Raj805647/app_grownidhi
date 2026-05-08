import 'package:app_grownidhi/features/screens/individual/home/home_screen.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';
import '../all_service/all_service_screen.dart';
import '../calender/calender_screen.dart';
import '../portfolio/portfolio_screen.dart';
import '../profile/profile_screen.dart';
import 'bottom_bar_provider.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final List<Map<String, dynamic>> navBarItems = [
    {'icon': Icons.home_outlined, 'label': 'home', 'screen': HomeScreen()},
    {
      'icon': Icons.bar_chart_outlined,
      'label': 'Portfolio',
      'screen': PortfolioScreen(),
    },
    {
      'icon': Icons.calendar_month_sharp,
      'label': 'Calender',
      'screen': CalendarScreen(),
    },
    {
      'icon': Icons.person_2_outlined,
      'label': 'Profile',
      'screen': ProfileScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: navBarItems[provider.selectedIndex]['screen'],

          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                provider.navigateTo(context, RouteNames.portfolioScreen),
            backgroundColor: Colors.green,
            elevation: 8,
            splashColor: Colors.green.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            height: 68,
            elevation: 10,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildItem(context, 0),
                _buildItem(context, 1),
                spaceWidth(40),
                _buildItem(context, 2),
                _buildItem(context, 3),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {
        final isSelected = provider.selectedIndex == index;

        return GestureDetector(
          onTap: () => provider.changeTab(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2.5,
                width: isSelected ? 24 : 0,
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              AnimatedScale(
                scale: isSelected ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  navBarItems[index]['icon'],
                  size: 25,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
              ),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                child: Text(navBarItems[index]['label']),
              ),
            ],
          ),
        );
      },
    );
  }
}
