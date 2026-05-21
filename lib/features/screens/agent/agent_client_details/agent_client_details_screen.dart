import 'package:app_grownidhi/features/screens/agent/agent_client_member_update_create/agent_client_member_update_create_screen.dart';
import 'package:app_grownidhi/features/screens/individual/kyc_update/kyc_update_screen.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/help_widget.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../agent_client_data/agent_client_data_provider.dart';
import '../agent_client_profile_details/agent_client_profile_details_screen.dart';
import 'agent_client_details_provider.dart';
import 'agent_client_member_details.dart';

class AgentClientDetailsScreen extends StatefulWidget {
  final AgentClientData? agentClientData;

  const AgentClientDetailsScreen({super.key, required this.agentClientData});

  @override
  State<AgentClientDetailsScreen> createState() =>
      _AgentClientDetailsScreenState();
}

class _AgentClientDetailsScreenState extends State<AgentClientDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.microtask(() {
      context.read<AgentClientDetailsProvider>().fetchClientMemberData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.agentClientData?.name ?? 'Client Details',
      ),
      body: Stack(
        children: [
          const AppGradientBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.12),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// Profile Image
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            widget.agentClientData?.profileImage != null
                            ? NetworkImage(
                                '${AppConfig.imageUrl}/${widget.agentClientData!.profileImage}',
                              )
                            : null,
                        child: widget.agentClientData?.profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),

                      const SizedBox(height: 14),

                      /// Name
                      Text(
                        widget.agentClientData?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(
                            widget.agentClientData!.status,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          (widget.agentClientData?.status != null &&
                                  widget.agentClientData?.status == true)
                              ? 'Active'
                              : 'Inactive',
                          style: TextStyle(
                            color: _statusColor(widget.agentClientData?.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Details Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      buildDetailTile(
                        icon: Icons.email_outlined,
                        title: "Email",
                        value: widget.agentClientData?.email ?? 'N/A',
                      ),

                      buildDetailTile(
                        icon: Icons.phone,
                        title: "Phone",
                        value: widget.agentClientData?.phone ?? 'N/A',
                      ),

                      buildDetailTile(
                        icon: Icons.category_outlined,
                        title: "Type",
                        value: widget.agentClientData?.type ?? 'N/A',
                      ),

                      buildDetailTile(
                        icon: Icons.calendar_month,
                        title: "Created At",
                        value: widget.agentClientData?.createdAt ?? 'N/A',
                      ),

                      buildDetailTile(
                        icon: Icons.person_outline,
                        title: "Created By",
                        value: '${widget.agentClientData?.createdBy}',
                      ),
                    ],
                  ),
                ),
                spaceHeight(20),
                buildClientAction(
                  onProfileTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AgentClientProfileDetailsScreen(),
                      ),
                    );
                  },
                  onKycTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            KycUpdateScreen(),
                      ),
                    );
                  },
                ),
                spaceHeight(20),
                buildClientMemberData(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClientAction({
    VoidCallback? onProfileTap,
    VoidCallback? onKycTap,
  }) {
    return Row(
      children: [

        /// COMPLETE PROFILE BUTTON
        Expanded(
          child: InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff4F46E5),
                    Color(0xff4338CA),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff4F46E5)
                        .withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 20,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Complete Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        /// CLIENT KYC BUTTON
        Expanded(
          child: InkWell(
            onTap: onKycTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xff10B981),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.verified_user_outlined,
                    color: Color(0xff10B981),
                    size: 20,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Client KYC",
                    style: TextStyle(
                      color: Color(0xff10B981),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildClientMemberData() {
    return Consumer<AgentClientDetailsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final filterMemberList = provider.agentClientMemberData
            .where(
              (e) =>
          e.clientId ==
              widget.agentClientData?.id,
        )
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Client Members",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            /// Members List - Horizontal scrolling
            Row(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.12),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AgentClientMemberUpdateCreateScreen(
                                clientUserId: widget.agentClientData?.id ?? 0,
                              ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white, size: 80),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                ),
                spaceWidth(10),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filterMemberList.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final member =
                            filterMemberList[index].familyMember;

                        return SizedBox(
                          width: 150,
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgentClientMemberDetails(
                                  agentClientMemberData: member,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.grey.shade50],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  /// Member Name
                                  Text(
                                    member?.name ?? "N/A",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 6),

                                  /// Member Email
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          member?.email ?? "N/A",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Detail Tile Widget
  Widget buildDetailTile({
    required IconData icon,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.blue, size: 22),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Status Color
  Color _statusColor(bool? status) {
    switch (status) {
      case true:
        return Colors.green;
      case false:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
