import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'agent_earning_provider.dart';

class AgentEarningScreen extends StatelessWidget {
  AgentEarningScreen({super.key});

  Color kPrimary = Color(0xFF5B67F1),
      kSecondary = Color(0xFF7C4DFF),
      kBackground = Color(0xFFF5F7FF),
      kCard = Colors.white,
      kTextDark = Color(0xFF1E293B),
      kTextLight = Color(0xFF64748B),
      kBorder = Color(0xFFE2E8F0);
  @override
  Widget build(BuildContext context) {
    return Consumer<AgentEarningProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,

          body: Stack(
            children: [
              /// BACKGROUND
              const AppGradientBackground(),

              CustomScrollView(
                physics: const BouncingScrollPhysics(),

                slivers: [
                  /// APP BAR
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: true,
                    expandedHeight: 120,

                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: 20, bottom: 18),

                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: const [
                          Text(
                            "Earnings",
                            style: TextStyle(
                              color: Color(0xFF1E293B),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Track your commissions & revenue",
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),

                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.notifications_none,
                          color: Color(0xFF5B67F1),
                        ),
                      ),
                    ],
                  ),

                  /// BODY
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 120,
                      ),

                      child: Column(
                        children: [
                          /// TOTAL EARNING CARD
                          Container(
                            width: double.infinity,

                            padding: const EdgeInsets.all(24),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),

                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,

                                colors: [Color(0xFF5B67F1), Color(0xFF7C4DFF)],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5B67F1,
                                  ).withOpacity(0.22),

                                  blurRadius: 24,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: const [
                                        Text(
                                          "Total Earnings",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                          ),
                                        ),

                                        SizedBox(height: 8),

                                        Text(
                                          "Overall Revenue",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      padding: const EdgeInsets.all(14),

                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.14),

                                        borderRadius: BorderRadius.circular(18),
                                      ),

                                      child: const Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 26),

                                Text(
                                  "₹ ${provider.commissionSummary['totalCommission']}",

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 28),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _earningMiniCard(
                                        "This Month",
                                        "₹ ${provider.commissionSummary['thisMonth']}",
                                        Icons.trending_up,
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: _earningMiniCard(
                                        "Last Month",
                                        "₹ ${provider.commissionSummary['lastMonth']}",
                                        Icons.calendar_month,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          /// GRAPH SECTION
                          Container(
                            padding: const EdgeInsets.all(22),

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(30),

                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 18,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: [
                                    const Text(
                                      "Revenue Overview",
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),

                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF5B67F1,
                                        ).withOpacity(0.08),

                                        borderRadius: BorderRadius.circular(14),
                                      ),

                                      child: const Text(
                                        "2026",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF5B67F1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 34),

                                SizedBox(
                                  height: 240,

                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: provider.monthlyEarnings.map((e) {
                                      double value =
                                          provider.selectedChartIndex == 0
                                          ? e['amount'].toDouble()
                                          : e['policies'].toDouble() * 250;

                                      return Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,

                                          children: [
                                            Text(
                                              "₹ ${e['amount']}",

                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF64748B),
                                              ),
                                            ),

                                            const SizedBox(height: 10),

                                            AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 500,
                                              ),

                                              height: value / 35,

                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                  ),

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),

                                                gradient: const LinearGradient(
                                                  begin: Alignment.bottomCenter,

                                                  end: Alignment.topCenter,

                                                  colors: [
                                                    Color(0xFF5B67F1),
                                                    Color(0xFF7C4DFF),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 12),

                                            Text(
                                              e['month'],

                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dashboardCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(color: kBorder),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),

      child: child,
    );
  }

  Widget screenHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: TextStyle(
            color: kTextDark,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 6),

        Text(subtitle, style: TextStyle(color: kTextLight, fontSize: 14)),
      ],
    );
  }

  Widget gradientSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(24),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5B67F1), Color(0xFF7C4DFF)],
        ),

        boxShadow: [
          BoxShadow(
            color: Color(0xFF5B67F1).withOpacity(0.25),
            blurRadius: 25,
            offset: Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Icon(icon, color: Colors.white, size: 30),
          ),

          SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                SizedBox(height: 6),

                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(24),

          border: Border.all(color: kBorder),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),

              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kPrimary, kSecondary]),

                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(icon, color: Colors.white, size: 22),
            ),

            SizedBox(height: 14),

            Text(
              value,
              style: TextStyle(
                color: kTextDark,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextLight, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),

      child: Text(
        title,
        style: TextStyle(
          color: kTextDark,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget portfolioCard(ServiceSubCategoryData item) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(color: kBorder),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            height: 64,
            width: 64,

            padding: EdgeInsets.all(14),

            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [kPrimary, kSecondary]),

              borderRadius: BorderRadius.circular(20),
            ),

            child: item.icon?.isEmpty ?? true
                ? Icon(Icons.account_balance_wallet, color: Colors.white)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),

                    child: Image.network(
                      '${AppConfig.imageUrl}/${item.icon}',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),

          Spacer(),

          Text(
            item.name ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              color: kTextDark,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8),

          Text(
            item.value ?? "₹ 0",
            style: TextStyle(color: kTextLight, fontSize: 14),
          ),

          SizedBox(height: 14),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),

            decoration: BoxDecoration(
              color: kPrimary.withOpacity(0.08),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Text(
              item.type ?? "Portfolio",
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryTab({required bool selected, required String title}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),

      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),

      decoration: BoxDecoration(
        gradient: selected
            ? LinearGradient(colors: [kPrimary, kSecondary])
            : null,

        color: selected ? null : Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: selected ? Colors.transparent : kBorder),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),

      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : kTextDark,

          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget exportCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(24),

          border: Border.all(color: kBorder),

          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12),
          ],
        ),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: color.withOpacity(0.1),

                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(icon, color: color, size: 28),
            ),

            SizedBox(height: 12),

            Text(
              title,
              style: TextStyle(color: kTextDark, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _earningMiniCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: Colors.white, size: 20),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
