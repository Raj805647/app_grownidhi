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
    {
      'icon': Icons.home_rounded,
      'label': 'Home',
      'screen': HomeScreen(),
    },

    {
      'icon': Icons.pie_chart_rounded,
      'label': 'Portfolio',
      'screen': PortfolioScreen(),
    },

    {
      'icon': Icons.calendar_month_rounded,
      'label': 'Calendar',
      'screen': CalendarScreen(),
    },

    {
      'icon': Icons.person_rounded,
      'label': 'Profile',
      'screen': ProfileScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {

        return Scaffold(
          backgroundColor: const Color(0xffF5F7FB),

          extendBody: true,

          body: Stack(
            children: [

              /// ACTIVE SCREEN
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),

                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,

                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.05, 0),
                        end: Offset.zero,
                      ).animate(animation),

                      child: child,
                    ),
                  );
                },

                child: Container(
                  key: ValueKey(provider.selectedIndex),
                  child:
                  navBarItems[provider.selectedIndex]['screen'],
                ),
              ),

              /// PREMIUM FLOATING BOTTOM BAR
              Positioned(
                left: 18,
                right: 18,
                bottom: 18,

                child: Container(
                  height: 78,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),

                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [
                        Color(0xff111827),
                        Color(0xff1E293B),
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),

                      BoxShadow(
                        color:
                        const Color(0xff6366F1).withOpacity(0.10),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Expanded(
                        child: _navItem(
                          provider,
                          index: 0,
                        ),
                      ),

                      Expanded(
                        child: _navItem(
                          provider,
                          index: 1,
                        ),
                      ),

                      const SizedBox(width: 64),

                      Expanded(
                        child: _navItem(
                          provider,
                          index: 2,
                        ),
                      ),

                      Expanded(
                        child: _navItem(
                          provider,
                          index: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CENTER FAB
              Positioned(
                bottom: 42,
                left: MediaQuery.of(context).size.width / 2 - 32,

                child: GestureDetector(
                  onTap: () {
                    provider.navigateTo(
                      context,
                      RouteNames.portfolioScreen,
                    );
                  },

                  child: Container(
                    height: 64,
                    width: 64,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff6366F1),
                          Color(0xff8B5CF6),
                        ],
                      ),

                      boxShadow: [
                        BoxShadow(
                          color:
                          const Color(0xff6366F1).withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _navItem(
      BottomBarProvider provider, {
        required int index,
      }) {
    final bool isSelected =
        provider.selectedIndex == index;

    return GestureDetector(
      onTap: () => provider.changeTab(index),

      behavior: HitTestBehavior.opaque,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          gradient: isSelected
              ? const LinearGradient(
            colors: [
              Color(0xff6366F1),
              Color(0xff8B5CF6),
            ],
          )
              : null,

          color: isSelected
              ? null
              : Colors.transparent,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: isSelected ? 1.15 : 1,

              child: Icon(
                navBarItems[index]['icon'],
                size: 24,

                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.55),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              navBarItems[index]['label'],

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,

                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}