import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/agent_client_member_data_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'agent_client_details_provider.dart';

class AgentClientMemberDetails extends StatelessWidget {
  final FamilyMember? agentClientMemberData;

  const AgentClientMemberDetails({
    super.key,
    required this.agentClientMemberData,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentClientDetailsProvider>(
      builder: (context, provider, child) =>  Scaffold(
        extendBodyBehindAppBar: true,

        appBar: CustomAppBar(title: "Member Details",actions: [
          /// UPDATE
          buildActionButton(
            icon: Icons.edit_outlined,
            color: Colors.blue,
            onTap: () {
              /// Update Action
            },
          ),

          const SizedBox(width: 10),

          /// DELETE
          buildActionButton(
            icon: Icons.delete_outline,
            color: Colors.red,
            onTap: () => showDeleteDialog(context,provider),
          ),
        ]),

        body: Stack(
          children: [
            /// Gradient Background
            AppGradientBackground(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                children: [
                  /// PROFILE CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white.withOpacity(0.12),

                      border: Border.all(color: Colors.white.withOpacity(0.15)),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        /// PROFILE IMAGE
                        Hero(
                          tag: agentClientMemberData?.id ?? "",

                          child: Container(
                            padding: const EdgeInsets.all(4),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.25),
                                  blurRadius: 14,
                                ),
                              ],
                            ),

                            child: CircleAvatar(
                              radius: 52,
                              backgroundColor: Colors.white,

                              child: Icon(
                                Icons.person,
                                size: 56,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// NAME
                        Text(
                          agentClientMemberData?.name ?? "N/A",

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// RELATIONSHIP
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Text(
                            agentClientMemberData?.relationship ?? "Unknown",

                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// CHIPS
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,

                          children: [
                            buildTopChip(
                              Icons.wc,
                              agentClientMemberData?.gender ?? "N/A",
                            ),

                            buildTopChip(
                              Icons.verified_user_outlined,
                              agentClientMemberData?.isDependent == true
                                  ? "Dependent"
                                  : "Independent",
                            ),

                            buildTopChip(
                              Icons.work_outline,
                              agentClientMemberData?.occupation ?? "N/A",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  /// DETAILS CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        buildDetailTile(
                          Icons.cake_outlined,
                          "Date of Birth",
                          agentClientMemberData?.dob ?? "N/A",
                        ),

                        buildDetailTile(
                          Icons.phone_outlined,
                          "Contact Number",
                          agentClientMemberData?.contactNumber ?? "N/A",
                        ),

                        buildDetailTile(
                          Icons.email_outlined,
                          "Email",
                          agentClientMemberData?.email ?? "N/A",
                        ),

                        buildDetailTile(
                          Icons.currency_rupee,
                          "Annual Income",
                          "₹ ${agentClientMemberData?.annualIncome ?? "0"}",
                        ),

                        buildDetailTile(
                          Icons.badge_outlined,
                          "PAN Number",
                          agentClientMemberData?.pan ?? "N/A",
                        ),

                        buildDetailTile(
                          Icons.credit_card,
                          "Aadhar Number",
                          agentClientMemberData?.aadharNumber ?? "N/A",
                        ),

                        buildDetailTile(
                          Icons.note_alt_outlined,
                          "Notes",
                          agentClientMemberData?.notes ?? "N/A",
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  /// DOCUMENTS
                  if ((agentClientMemberData?.documents ?? []).isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 14,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.folder_copy_outlined,
                                  color: Colors.purple.shade700,
                                ),
                              ),

                              const SizedBox(width: 12),

                              const Text(
                                "Documents",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          GridView.builder(
                            itemCount:
                                agentClientMemberData?.documents?.length ?? 0,

                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 0.9,
                                ),

                            itemBuilder: (context, index) {
                              final doc =
                                  agentClientMemberData?.documents?[index] ?? "";

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Colors.grey.shade100,
                                ),

                                child: Column(
                                  children: [
                                    /// IMAGE PREVIEW
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(22),
                                        ),

                                        child: Image.network(
                                          doc,
                                          width: double.infinity,
                                          fit: BoxFit.cover,

                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              color: Colors.grey.shade200,

                                              child: Icon(
                                                Icons
                                                    .image_not_supported_outlined,
                                                size: 45,
                                                color: Colors.grey.shade500,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10),

                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              doc.split('/').last,

                                              overflow: TextOverflow.ellipsis,

                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 6),

                                          Icon(
                                            Icons.visibility_outlined,
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
  }

  /// ACTION BUTTON
  Widget buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),

      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  /// TOP CHIP
  Widget buildTopChip(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),

          const SizedBox(width: 6),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// DETAIL TILE
  Widget buildDetailTile(
    IconData icon,
    String title,
    String value, {
    bool isLast = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 18),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(11),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.15),
                  Colors.purple.withOpacity(0.15),
                ],
              ),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: Colors.deepPurple, size: 22),
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

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
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


  Future<void> showDeleteDialog(BuildContext context,AgentClientDetailsProvider provider) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text(
            "Are you sure you want to delete this member?",
          ),

          actions: [

            /// CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            /// DELETE
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {
                provider.deleteClientMember(agentClientMemberData?.id ?? 0);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }


}
