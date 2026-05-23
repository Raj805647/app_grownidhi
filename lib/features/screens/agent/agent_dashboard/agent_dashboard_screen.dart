import 'package:app_grownidhi/features/screens/agent/agent_notification/agent_notification_screen.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../routes/route_names.dart';
import '../../../../widget/help_widget.dart';
import '../agent_client_application/agent_client_application_details_screen.dart';
import '../agent_client_application/agent_client_application_screen.dart';
import '../agent_client_data/agent_client_data_screen.dart';
import '../agent_client_details/agent_client_details_screen.dart';
import '../agent_client_profile_details/agent_client_profile_details_screen.dart';
import 'agent_dashboard_provider.dart';

import 'package:flutter/material.dart';

class AgentDashboardScreen extends StatefulWidget {
  const AgentDashboardScreen({super.key});

  @override
  State<AgentDashboardScreen> createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
  // Theme Colors
  static const Color primaryGreen = Color(0xff14532D);
  static const Color darkGreen = Color(0xff0B1D16);
  static const Color cardColor = Color(0xff163328);

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentDashboardProvider>(). fetchAgentDashboard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AgentDashboardProvider>();
    return Scaffold(
      backgroundColor: darkGreen,
      drawer: _buildDrawer(context, provider),
      body: Stack(
        children: [
          const AppGradientBackground(),
          Consumer<AgentDashboardProvider>(
            builder: (context, provider, child) =>  CustomScrollView(
              slivers: [
                _buildAppBar(context),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildSummaryCards(provider),
                      const SizedBox(height: 28),
                      _buildQuickActions(provider),
                      const SizedBox(height: 28),
                      _buildClientSection(provider),
                      const SizedBox(height: 28),
                      _buildApplicationSection(provider),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Welcome back, Agent 👋",
            style: TextStyle(
              color: Colors.white.withOpacity(0.72),
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to notification screen
            Navigator.push(context, MaterialPageRoute(builder:   (context) => AgentNotificationScreen(),));
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(AgentDashboardProvider provider) {
    final data = provider.agentDashboardData;

    return SizedBox(
      height: 135,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildSummaryCard(
            title: 'Clients',
            value: "${data.totalClients ?? 0}",
            icon: Icons.people_alt_outlined,
            color: Colors.blue,
            change: '+12%',
            isUp: true,
          ),
          _buildSummaryCard(
            title: 'Policies',
            value: "${data.totalPolicies ?? 0}",
            icon: Icons.description_outlined,
            color: Colors.orange,
            change: '+5%',
            isUp: true,
          ),
          _buildSummaryCard(
            title: 'Commission',
            value: "${data.totalCommission ?? 0}",
            icon: Icons.wallet,
            color: Colors.greenAccent,
            change: '+8%',
            isUp: true,
          ),
          _buildSummaryCard(
            title: 'Earnings',
            value: "${data.totalEarning ?? 0}",
            icon: Icons.trending_up,
            color: Colors.purpleAccent,
            change: '+15%',
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
      width: 170,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isUp
                        ? Colors.greenAccent.withOpacity(0.15)
                        : Colors.redAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUp ? Icons.trending_up : Icons.trending_down,
                        color: isUp ? Colors.greenAccent : Colors.redAccent,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        change,
                        style: TextStyle(
                          color: isUp ? Colors.greenAccent : Colors.redAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.70),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(AgentDashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quickActionItem(
                icon: Icons.person_add_alt_1,
                title: 'Client',
                onTap: () => _showSnackBar('Add Client'),
              ),
              _quickActionItem(
                icon: Icons.policy,
                title: 'Policy',
                onTap: () =>
                    provider.navigateTo(context, RouteNames.agentKycScreen),
              ),

              _quickActionItem(
                icon: Icons.verified_user,
                title: 'KYC',
                onTap: () => _showSnackBar('KYC Verification'),
              ),
              _quickActionItem(
                icon: Icons.payments,
                title: 'Claim',
                onTap: () => provider.navigateTo(
                  context,
                  RouteNames.agentClientDataScreen,
                ),
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
    final provider = context.read<AgentDashboardProvider>();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Icon(icon, color: Colors.greenAccent, size: 30),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.80),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientSection(AgentDashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            'Clients',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AgentClientDataScreen()),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 100,
            child: provider.agentClientData.isEmpty
                ? const Center(child: Text("No Client Found", style: TextStyle(color:  Colors.white),))
                : ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: provider.agentClientData.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final client = provider.agentClientData[index];

                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgentClientProfileDetailsScreen(
                        clientId: client.id ?? 0,
                      ),
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
                                  child:
                                  (client.profileImage == null ||
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
                                          color: Colors.white.withOpacity(
                                            0.8,
                                          ),
                                          size: 16,
                                        ),

                                        const SizedBox(width: 6),

                                        Expanded(
                                          child: Text(
                                            client.phone ?? "No Phone",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.85),
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
      ),
    );
  }

  Widget _buildApplicationSection(AgentDashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            'Applications',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgentClientApplicationScreen(
                  clientList: provider.clientApplication,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ListView.separated(
            itemCount: provider.clientApplication.length,
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
            const SizedBox(height: 12),
            itemBuilder: (context, index) {

              final item = provider.clientApplication[index];

              return InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AgentClientApplicationDetailsScreen(clientDetails: item),)),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xff222C44),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [

                      /// Profile
                      CircleAvatar(
                        radius: 24,
                        backgroundColor:
                        Colors.blueAccent,
                        child: Text(
                          item.client?.name
                              ?.substring(0, 1)
                              .toUpperCase() ??
                              "N",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      /// Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              item.client?.name ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item.product?.productName ??
                                  "",
                              style: TextStyle(
                                color:
                                Colors.grey.shade400,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item.product?.category ??
                                  "",
                              style: TextStyle(
                                color:
                                Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: item.status == "pending"
                              ? Colors.orange
                              .withOpacity(0.15)
                              : Colors.green
                              .withOpacity(0.15),
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Text(
                          item.status ?? "",
                          style: TextStyle(
                            color:
                            item.status == "pending"
                                ? Colors.orange
                                : Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'View All',
            style: TextStyle(
              color: Colors.greenAccent.shade100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context, AgentDashboardProvider provider) {
    return Drawer(
      backgroundColor: const Color(0xff10261D),
      child: Column(
        children: [
          _buildDrawerHeader(context),
          const SizedBox(height: 20),
          _drawerTile(
            icon: Icons.person,
            title: 'My Profile',
            subtitle: 'View and edit profile',
            color: Colors.blueAccent,
            onTap: () =>
                provider.navigateTo(context, RouteNames.agentMyProfileScreen),
          ),
          _drawerTile(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'App preferences',
            color: Colors.orangeAccent,
            onTap: () => _showSnackBar('Navigate to Settings'),
          ),
          _drawerTile(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out from app',
            color: Colors.redAccent,
            onTap: () => AppDialogs.showLogoutDialog(
              context,
              RouteNames.signInScreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 55, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff14532D), Color(0xff0F3D2E)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 34, color: Color(0xff14532D)),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agent Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text('Welcome Back 👋', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        tileColor: Colors.white.withOpacity(0.06),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: primaryGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
