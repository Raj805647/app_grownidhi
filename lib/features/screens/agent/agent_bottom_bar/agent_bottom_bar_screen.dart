import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';
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

          /// BODY
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),

              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,

                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.08, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),

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

          /// FLOATING PREMIUM BOTTOM BAR
          Positioned(
            left: 18,
            right: 18,
            bottom: 22,

            child: Container(
              height: 78,

              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),

                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Color(0xff10131A),
                    Color(0xff1B2230),
                  ],
                ),

                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),

                  BoxShadow(
                    color: const Color(0xff6C63FF).withOpacity(0.12),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [

                  _premiumNavItem(
                    icon: Icons.home_rounded,
                    label: "Home",
                    index: 0,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(0),
                  ),

                  _premiumNavItem(
                    icon: Icons.folder_copy_rounded,
                    label: "Portfolio",
                    index: 1,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(1),
                  ),

                  _premiumNavItem(
                    icon: Icons.account_balance_wallet_rounded,
                    label: "Earnings",
                    index: 2,
                    selectedIndex: navProvider.selectedIndex,
                    onTap: () => navProvider.setSelectedIndex(2),
                  ),

                  _premiumNavItem(
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

  Widget _premiumNavItem({
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        behavior: HitTestBehavior.opaque,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,

          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            gradient: isSelected
                ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: [
                Color(0xff6C63FF),
                Color(0xff8B84FF),
              ],
            )
                : null,

            color: isSelected
                ? null
                : Colors.transparent,

            boxShadow: isSelected
                ? [
              BoxShadow(
                color: const Color(0xff6C63FF).withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ]
                : [],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: isSelected ? 1.15 : 1,

                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                ),
              ),

              const SizedBox(height: 5),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),

                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,

                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.55),
                ),

                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
