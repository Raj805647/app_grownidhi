import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../widget/help_widget.dart';
import '../../../widget/ui_design.dart';
import 'home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xfff5f7fb),
          body: Stack(
            children: [
              AppGradientBackground(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedHeader(provider),
                    spaceHeight(20),
                    _buildAnimatedNetWorthCard(provider),
                    spaceHeight(20),
                    _buildPortfolio(provider),
                    spaceHeight(20),
                    _buildUpcomingAction(),
                    spaceHeight(20),
                    _buildQuickActions(),
                    spaceHeight(30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedHeader(HomeProvider provider) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: const Text(
                    'R',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              spaceWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good Evening 👋",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    provider.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedNetWorthCard(HomeProvider provider) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Color(0xFF243B53)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP TITLE
          Row(
            children: [
              const Text(
                "Total Net Worth",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              spaceWidth(6),
              Icon(
                Icons.auto_awesome,
                color: Colors.greenAccent.shade200,
                size: 18,
              ),
            ],
          ),

          spaceHeight(12),

          /// AMOUNT + ACTIONS
          Row(
            children: [
              const Expanded(
                child: Text(
                  "₹15,40,000",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              /// Eye Button
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white70,
                  size: 18,
                ),
              ),

              spaceWidth(10),

              /// Profit Chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.greenAccent.withOpacity(0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.north_east, color: Colors.greenAccent, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "+2.3%",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          spaceHeight(18),

          /// CUSTOM BAR GRAPH
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                14,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 400 + (index * 50)),
                  width: 14,
                  height: 25 + (index * 3).toDouble(),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),

          spaceHeight(10),

          Divider(color: Colors.white.withOpacity(0.08), thickness: 1),

          spaceHeight(10),

          /// BOTTOM INFO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFinanceInfoItem(title: "Investment", value: "₹5.8L"),
              _buildFinanceInfoItem(title: "Liability", value: "₹8.2L"),
              _buildFinanceInfoItem(title: "Insurance", value: "₹12.5L"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceInfoItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11),
        ),
        spaceHeight(6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolio(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Portfolio Overview",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        spaceHeight(12),
        GridView.builder(
          shrinkWrap: true,
          itemCount: provider.portfolioItems.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final item = provider.portfolioItems[index];

            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1),
              duration: Duration(milliseconds: 300 + (index * 100)),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: _buildPortfolioCard(
                    item["title"],
                    item["value"],
                    item["change"],
                    item["color"],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingAction() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Upcoming Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("View All", style: TextStyle(color: Colors.green)),
          ],
        ),
        spaceHeight(10),
        _buildActionCard(
          "Life Insurance Premium",
          "₹12,500",
          "Due in 5 days",
          true,
        ),
        _buildActionCard("Home Loan EMI", "₹45,000", "Due in 10 days", false),
        _buildActionCard("Credit Card Bill", "₹15,234", "Paid", false),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    String amount,
    String subtitle,
    bool isDue,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔹 ICON (colored like fintech UI)
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: isDue ? Colors.orange.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shield_outlined,
              color: isDue ? Colors.orange : Colors.green,
            ),
          ),

          const SizedBox(width: 12),

          /// 🔹 TITLE + SUBTITLE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                spaceHeight(4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          /// 🔹 AMOUNT + STATUS
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              spaceHeight(6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDue
                      ? Colors.orange.withOpacity(0.15)
                      : Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isDue ? "Due Soon" : "Active",
                  style: TextStyle(
                    color: isDue ? Colors.orange : Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 6),

          /// 🔹 ARROW (optional - looks premium)
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickAction(
              Icons.security_outlined,
              "Insurance",
              Colors.blue,
            ),
            _buildQuickAction(
              Icons.account_balance_wallet,
              "Loans",
              Colors.purple,
            ),
            _buildQuickAction(Icons.trending_up, "Invest", Colors.green),
            _buildQuickAction(Icons.credit_card, "Cards", Colors.orange),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPortfolioCard(String title, value, change, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: const Icon(Icons.show_chart, color: Colors.white),
          ),
          spaceHeight(10),
          Text(title),
          spaceHeight(4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            change,
            style: TextStyle(
              color: change.contains("-") ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return InkWell(
      onTap: (){

      },
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          spaceHeight(6),
          Text(label),
        ],
      ),
    );
  }
}
