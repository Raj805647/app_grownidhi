import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../routes/route_names.dart';
import 'agent_dashboard_provider.dart';

class AgentDashboardScreen extends StatelessWidget {
  AgentDashboardScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgentDashboardProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: CustomDrawer.build(context),
      body: Stack(
        children: [
          // AppGradientBackground(),
          RefreshIndicator(
            onRefresh: () => provider.fetchDashboardData(),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context),
                if (provider.isLoading)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (provider.error != null)
                  SliverFillRemaining(child: _buildErrorWidget(provider.error!))
                else if (provider.dashboardData != null)
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 8),
                      _buildSummaryCards(provider.dashboardData!.summaryCards),
                      const SizedBox(height: 24),
                      _buildQuickActions(provider, context, provider.dashboardData!.quickActions),
                      const SizedBox(height: 24),
                      _buildUpcomingRenewals(
                        provider.dashboardData!.upcomingRenewals,
                      ),
                      const SizedBox(height: 24),
                      _buildPendingCommissions(
                        provider.dashboardData!.pendingCommissions,
                      ),
                      const SizedBox(height: 24),
                      _buildNotifications(
                        provider.dashboardData!.notifications,
                        provider,
                      ),
                      const SizedBox(height: 80),
                    ]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Failed to load dashboard',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(error, style: TextStyle(color: Colors.grey.shade500)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40,top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome back, Agent',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Badge(
            label: const Text('3'),
            child: Icon(Icons.notifications_none, color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildSummaryCards(List<SummaryCard> cards) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  card.color.withOpacity(0.1),
                  card.color.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: card.color.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(card.icon, color: card.color, size: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: card.trend == Trend.up
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              card.trend == Trend.up
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              size: 12,
                              color: card.trend == Trend.up
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              card.change,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: card.trend == Trend.up
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.title,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActions(AgentDashboardProvider provider,BuildContext context,  List<QuickAction> actions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(actions.length, (index) {
              final action = actions[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () => provider.navigateTo(context, RouteNames.kycScreen),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: index < actions.length - 1 ? 12 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: action.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(action.icon, color: action.color, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          action.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: action.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingRenewals(List<RenewalItem> renewals) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Renewals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: Color(0xFF6C63FF)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: renewals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final renewal = renewals[index];
              final daysLeft = renewal.renewalDate
                  .difference(DateTime.now())
                  .inDays;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.event, color: Color(0xFFFF9800)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            renewal.clientName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${renewal.policyType} • ${renewal.premium}/month',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: daysLeft <= 7
                                  ? Colors.red.shade50
                                  : Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$daysLeft days left',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: daysLeft <= 7
                                    ? Colors.red
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPendingCommissions(List<CommissionItem> commissions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pending Commissions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: Color(0xFF6C63FF)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...commissions.map(
            (commission) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.payments, color: Color(0xFF4CAF50)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commission.clientName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          commission.policyType,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        commission.amount,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: commission.status == CommissionStatus.pending
                              ? Colors.orange.shade50
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          commission.status == CommissionStatus.pending
                              ? 'Pending'
                              : 'Processing',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: commission.status == CommissionStatus.pending
                                ? Colors.orange
                                : Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifications(
    List<NotificationItem> notifications,
    AgentDashboardProvider provider,
  ) {
    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$unreadCount new',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...notifications.asMap().entries.map((entry) {
            final index = entry.key;
            final notification = entry.value;
            return GestureDetector(
              onTap: () => provider.markNotificationAsRead(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.white
                      : const Color(0xFF6C63FF).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: notification.isRead
                      ? null
                      : Border.all(
                          color: const Color(0xFF6C63FF).withOpacity(0.3),
                        ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: notification.isRead
                            ? Colors.grey.shade100
                            : const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        notification.icon,
                        color: notification.isRead
                            ? Colors.grey.shade600
                            : const Color(0xFF6C63FF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                              color: notification.isRead
                                  ? Colors.grey.shade700
                                  : const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.time,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6C63FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CustomDrawer {
  static Drawer build(BuildContext context) {
 final provider = context.read<AgentDashboardProvider>();
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(context),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerTile(
                    context,
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    subtitle: 'View and edit your profile',
                    color: const Color(0xFF6C63FF),
                    onTap: () => provider.navigateTo(context, RouteNames.agentMyProfileScreen),
                  ),

                  _buildDrawerTile(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    color: const Color(0xFF607D8B),
                    onTap: () => _navigateTo(context, '/settings'),
                  ),

                  _buildDrawerTile(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: 'Sign out from account',
                    color: Colors.red,
                    onTap: () => AppDialogs.showLogoutDialog(context, RouteNames.signInScreen),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER
  static Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 32, child: Icon(Icons.person)),

          SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sarah Johnson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4),

              Text('Premium Agent', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  // TILE
  static Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),

      subtitle: Text(subtitle),

      trailing: const Icon(Icons.chevron_right),

      onTap: onTap,
    );
  }

  // NAVIGATION
  static void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigate to $route')));
  }

  }
