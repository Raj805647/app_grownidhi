import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';
import '../notification/notification_screen.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color backgroundColor = Color(0xff0F172A);
  static Color cardColor = Colors.white.withOpacity(0.05);
  static const Color accentColor = Color(0xff22C55E);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<HomeProvider>().fetchDashboard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: HomeScreen.backgroundColor,

          body: Stack(
            children: [
              /// BACKGROUND
              AppGradientBackground(),

              RefreshIndicator(
                onRefresh: ()async{
                  await provider.fetchDashboard();
              },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// HEADER
                      buildHomeHeader(context, provider),

                      const SizedBox(height: 24),

                      /// DASHBOARD GRID
                      buildDashboardGrid(provider),

                      const SizedBox(height: 24),

                      /// NET WORTH CARD
                      buildNetWorthCard(),

                      const SizedBox(height: 28),

                      /// PORTFOLIO
                      buildSectionHeading("Portfolio Overview"),

                      const SizedBox(height: 18),

                      buildPortfolioGrid(provider),

                      const SizedBox(height: 28),

                      /// UPCOMING ACTIONS
                      buildSectionHeading("Upcoming Actions"),

                      const SizedBox(height: 18),

                      _actionCard(
                        title: "Life Insurance Premium",
                        amount: "₹12,500",
                        subtitle: "Due in 5 days",
                      ),

                      _actionCard(
                        title: "Home Loan EMI",
                        amount: "₹45,000",
                        subtitle: "Due in 10 days",
                      ),

                      const SizedBox(height: 28),

                      /// QUICK ACTIONS
                      buildSectionHeading("Quick Actions"),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          _quickAction(Icons.security, "Insurance"),

                          _quickAction(Icons.account_balance_wallet, "Loans"),

                          _quickAction(Icons.trending_up, "Invest"),

                          _quickAction(Icons.credit_card, "Cards"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ================= HEADER =================

  Widget buildHomeHeader(BuildContext context, HomeProvider provider) {
    return Row(
      children: [
        /// PROFILE
        Container(
          height: 56,
          width: 56,

          decoration: BoxDecoration(
            color: HomeScreen.cardColor,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),

          child: const Center(
            child: Text(
              "R",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        /// NAME
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Welcome Back 👋",

              style: TextStyle(
                color: Colors.white.withOpacity(0.60),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              provider.userName,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const Spacer(),

        /// NOTIFICATION
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen()),
          ),

          child: Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: HomeScreen.cardColor,

              borderRadius: BorderRadius.circular(16),

              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),

            child: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// ================= DASHBOARD GRID =================

  Widget buildDashboardGrid(HomeProvider provider) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      crossAxisSpacing: 14,
      mainAxisSpacing: 14,

      /// LOW HEIGHT
      childAspectRatio: 1.75,

      children: [
        dashboardCard(
          title: "Members",
          value: "${provider.individualDashboardData.totalMembers ?? 0}",
          icon: Icons.groups_rounded,
          color: Colors.blue,
        ),

        dashboardCard(
          title: "Policies",
          value: "${provider.individualDashboardData.totalPolicies ?? 0}",
          icon: Icons.policy_rounded,
          color: Colors.green,
        ),

        dashboardCard(
          title: "Pending",
          value: "${provider.individualDashboardData.pendingPolicies ?? 0}",
          icon: Icons.pending_actions_rounded,
          color: Colors.orange,
        ),

        dashboardCard(
          title: "Approved KYC",
          value: "${provider.individualDashboardData.approvedKyc ?? 0}",
          icon: Icons.verified_user_rounded,
          color: Colors.teal,
        ),

        dashboardCard(
          title: "Pending KYC",
          value: "${provider.individualDashboardData.pendingKyc ?? 0}",
          icon: Icons.hourglass_bottom_rounded,
          color: Colors.redAccent,
        ),

        dashboardCard(
          title: "Categories",
          value: "${provider.individualDashboardData.totalCategories ?? 0}",
          icon: Icons.category_rounded,
          color: Colors.purpleAccent,
        ),
      ],
    );
  }

  /// ================= DASHBOARD CARD =================

  Widget dashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      decoration: BoxDecoration(
        color: HomeScreen.cardColor,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),

      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.14),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(width: 12),

          /// VALUE
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  value,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  title,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.60),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ================= NET WORTH =================

  Widget buildNetWorthCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: HomeScreen.cardColor,

        borderRadius: BorderRadius.circular(32),

        border: Border.all(color: Colors.white.withOpacity(0.06)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Total Net Worth",

                    style: TextStyle(
                      color: Colors.white.withOpacity(0.60),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "₹15,40,000",

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: HomeScreen.accentColor.withOpacity(0.12),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Icon(
                  Icons.account_balance_wallet,
                  color: HomeScreen.accentColor,
                  size: 30,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          Row(
            children: [
              Expanded(child: _miniCard("Investment", "₹5.8L")),

              const SizedBox(width: 12),

              Expanded(child: _miniCard("Insurance", "₹12.5L")),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= SECTION TITLE =================

  Widget buildSectionHeading(String title) {
    return Text(
      title,

      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  /// ================= PORTFOLIO GRID =================

  Widget buildPortfolioGrid(HomeProvider provider) {
    return GridView.builder(
      itemCount: provider.portfolioItems.length,

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.12,
      ),

      itemBuilder: (context, index) {
        final item = provider.portfolioItems[index];

        return Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: HomeScreen.cardColor,

            borderRadius: BorderRadius.circular(28),

            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: HomeScreen.accentColor.withOpacity(0.12),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons.show_chart,
                  color: HomeScreen.accentColor,
                ),
              ),

              const Spacer(),

              Text(
                item['title'],

                style: TextStyle(
                  color: Colors.white.withOpacity(0.60),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                item['value'],

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                item['change'],

                style: const TextStyle(
                  color: HomeScreen.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _miniCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.60),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required String amount,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: HomeScreen.cardColor,
        borderRadius: BorderRadius.circular(26),

        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: HomeScreen.accentColor.withOpacity(0.12),

              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.shield_outlined,
              color: HomeScreen.accentColor,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.60),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: HomeScreen.accentColor.withOpacity(0.12),

                  borderRadius: BorderRadius.circular(30),
                ),

                child: const Text(
                  "Active",
                  style: TextStyle(
                    color: HomeScreen.accentColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String title) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,

          decoration: BoxDecoration(
            color: HomeScreen.cardColor,

            borderRadius: BorderRadius.circular(20),

            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),

          child: Icon(icon, color: HomeScreen.accentColor),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
