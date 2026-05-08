import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../agent_dashboard/agent_dashboard_screen.dart';
import '../agent_earning/agent_earning_screen.dart';
import '../agent_portfolio/agent_portfolio_screen.dart';
import '../agent_report/agent_report_screen.dart';

import 'agent_bottom_bar_provider.dart';

class AgentBottomBarScreen extends StatelessWidget {
  const AgentBottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<AgentBottomBarProvider>();

    final List<Widget> screens = [
       AgentDashboardScreen(),
       AgentPortfolioScreen(),
       AgentEarningScreen(),
       AgentReportScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      /// BODY
      body: Stack(
        children: [
          /// SCREEN BODY
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
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
                key: ValueKey(navProvider.selectedIndex),
                child: screens[navProvider.selectedIndex],
              ),
            ),
          ),

          /// CUSTOM BOTTOM BAR INSIDE BODY
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff5B4DFF),
                    Color(0xff7B61FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(
                    icon: Icons.home_rounded,
                    label: "Home",
                    index: 0,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(0),
                  ),

                  _navItem(
                    icon: Icons.folder_copy_rounded,
                    label: "Portfolio",
                    index: 1,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(1),
                  ),

                  _navItem(
                    icon: Icons.account_balance_wallet_rounded,
                    label: "Earnings",
                    index: 2,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(2),
                  ),

                  _navItem(
                    icon: Icons.bar_chart_rounded,
                    label: "Reports",
                    index: 3,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14 : 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: isSelected ? 28 : 24,
            ),

            const SizedBox(height: 4),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
