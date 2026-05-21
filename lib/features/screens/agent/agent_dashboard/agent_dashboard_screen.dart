import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../routes/route_names.dart';
import '../../../../widget/help_widget.dart';
import '../agent_client_data/agent_client_data_screen.dart';
import '../agent_client_details/agent_client_details_screen.dart';
import 'agent_dashboard_provider.dart';

class AgentDashboardScreen extends StatefulWidget {
  AgentDashboardScreen({super.key});

  @override
  State<AgentDashboardScreen> createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentDashboardProvider>(). agentClientDataProvider.fetchAgentClientData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AgentDashboardProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: CustomDrawer.build(context),
      body: Stack(
        children: [
          AppGradientBackground(),
          RefreshIndicator(
            onRefresh: () => provider.fetchAgentDashboard(),
            child: Consumer<AgentDashboardProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return CustomScrollView(
                  slivers: [
                    _buildAppBar(context),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        spaceHeight(8),
                        _buildSummaryCards(provider),
                        spaceHeight(24),
                        _buildQuickActions(provider, context),
                        spaceHeight(24),
                          _buildClientData(context, provider),
                      /* spaceHeight( 24),
                        _buildPendingCommissions(
                          provider.dashboardData!.pendingCommissions,
                        ),
                       spaceHeight( 24),
                        _buildNotifications(
                          provider.dashboardData!.notifications,
                          provider,
                        ),*/
                        spaceHeight(80),
                      ]),
                    ),
                  ],
                );
              },
            ),
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
          padding: const EdgeInsets.only(left: 40, top: 20),
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
              spaceHeight(4),
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

  Widget _buildClientData(
      BuildContext context,
      AgentDashboardProvider provider,
      ) {
    final clientProvider = provider.agentClientDataProvider;
    final clients = clientProvider.agentClientData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TOP ROW
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Clients",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AgentClientDataScreen()));
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        /// HORIZONTAL CLIENT LIST
        SizedBox(
          height: 100,
          child: clients.isEmpty
              ? const Center(
            child: Text("No Client Found"),
          )
              : ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: clients.length,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final client = clients[index];

              return InkWell(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AgentClientDetailsScreen(agentClientData: client),
                  ),
                ),
                child: Container(
                  width: 220,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff2563EB),
                        const Color(0xff1E40AF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff2563EB).withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [

                      /// BACKGROUND DESIGN
                      Positioned(
                        top: -25,
                        right: -25,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: -35,
                        left: -20,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [

                            /// PROFILE IMAGE
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                (client.profileImage != null &&
                                    client.profileImage!.isNotEmpty)
                                    ? NetworkImage(
                                  '${AppConfig.imageUrl}/${client.profileImage}',
                                )
                                    : null,
                                child: (client.profileImage == null ||
                                    client.profileImage!.isEmpty)
                                    ? const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.grey,
                                )
                                    : null,
                              ),
                            ),

                            const SizedBox(width: 14),

                            /// NAME + PHONE
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    client.name ?? "Unknown Client",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 16,
                                      ),

                                      const SizedBox(width: 6),

                                      Expanded(
                                        child: Text(
                                          client.phone ?? "No Phone",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                            Colors.white.withOpacity(0.85),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(AgentDashboardProvider provider) {
    final data = provider.agentDashboardData;

    return SizedBox(
      height: 130,

      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),

        children: [
          _buildSummaryCard(
            title: "Clients",
            value: "${data.totalClients ?? 0}",
            icon: Icons.people_alt_outlined,
            color: const Color(0xFF3B82F6),
            change: "+12%",
            isUp: true,
          ),

          _buildSummaryCard(
            title: "Commission",
            value: "₹${data.totalCommission ?? 0}",
            icon: Icons.account_balance_wallet_outlined,
            color: const Color(0xFF00C896),
            change: "+8%",
            isUp: true,
          ),

          _buildSummaryCard(
            title: "Policies",
            value: "${data.totalPolicies ?? 0}",
            icon: Icons.description_outlined,
            color: const Color(0xFFFFB020),
            change: "-2%",
            isUp: false,
          ),

          _buildSummaryCard(
            title: "Earnings",
            value: "₹${data.totalEarning ?? 0}",
            icon: Icons.trending_up,
            color: const Color(0xFF7C3AED),
            change: "+18%",
            isUp: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String change,
    required bool isUp,
  }) {
    return Container(
      width: 210,
      margin: const EdgeInsets.only(right: 14),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF0D1B2A), color.withOpacity(0.85)],
        ),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white12,

                  child: Icon(icon, color: Colors.white),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: isUp
                        ? Colors.greenAccent.withOpacity(0.15)
                        : Colors.red.withOpacity(0.15),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      Icon(
                        isUp ? Icons.trending_up : Icons.trending_down,

                        size: 14,

                        color: isUp ? Colors.greenAccent : Colors.redAccent,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        change,

                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,

                          color: isUp ? Colors.greenAccent : Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            Text(
              title,

              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),

            Text(
              value,

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(
    AgentDashboardProvider provider,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          spaceHeight(12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quickActionItem(
                icon: Icons.policy,
                title: "Add Policy",
                onTap: () {},
              ),

              _quickActionItem(
                icon: Icons.verified_user,
                title: "KYC",
                onTap: ()=> provider.navigateTo(context, RouteNames.agentKycScreen),
              ),

              _quickActionItem(
                icon: Icons.assignment,
                title: "Claim",
                onTap: () {},
              ),
              _quickActionItem(
                icon: Icons.message,
                title: "Add Client",
                onTap: ()=> provider.navigateTo(context, RouteNames.agentClientDataScreen),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickActionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.blue, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
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
                    onTap: () => provider.navigateTo(
                      context,
                      RouteNames.agentMyProfileScreen,
                    ),
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
                    onTap: () => AppDialogs.showLogoutDialog(
                      context,
                      RouteNames.signInScreen,
                    ),
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
