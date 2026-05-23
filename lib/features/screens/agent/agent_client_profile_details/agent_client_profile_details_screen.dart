import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_button.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/client_complete_profile_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../agent_client_add_update_profile/agent_client_add_update_profile_screen.dart';
import 'agent_client_profile_details_provider.dart';

class AgentClientProfileDetailsScreen extends StatefulWidget {
  final int clientId;

  const AgentClientProfileDetailsScreen({super.key, required this.clientId});

  @override
  State<AgentClientProfileDetailsScreen> createState() =>
      _AgentClientProfileDetailsScreenState();
}

class _AgentClientProfileDetailsScreenState
    extends State<AgentClientProfileDetailsScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context
          .read<AgentClientProfileDetailsProvider>()
          .getClientCompleteProfile(widget.clientId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: CustomAppBar(title: 'Client Details'),

      body: Stack(
        children: [
          AppGradientBackground(),

          Consumer<AgentClientProfileDetailsProvider>(
            builder: (context, provider, child) {
              final v = provider.completeData;

              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final bool hasProfile = v.id != null;
              if(!hasProfile){
                return emptyProfileCard(context);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),

                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,

                            colors: [Color(0xff1E293B), Color(0xff0F172A)],
                          ),

                          border: Border.all(color: Colors.white12),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            /// PROFILE IMAGE
                            CircleAvatar(
                              radius: 46,

                              backgroundColor: Colors.blueAccent.withOpacity(0.2),

                              child: Text(
                                (v.fullName?.isNotEmpty ?? false)
                                    ? v.fullName![0].toUpperCase()
                                    : "C",

                                style: const TextStyle(
                                  fontSize: 34,

                                  fontWeight: FontWeight.bold,

                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            /// NAME
                            Text(
                              v.fullName ?? "Client Profile",

                              style: const TextStyle(
                                color: Colors.white,

                                fontSize: 24,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            /// EMAIL
                            Text(
                              v.email ?? "No Email Found",

                              style: TextStyle(
                                color: Colors.grey.shade400,

                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 14),

                            /// MOBILE
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),

                                borderRadius: BorderRadius.circular(14),
                              ),

                              child: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.greenAccent,
                                    size: 18,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    v.mobileNumber ?? "-",

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),
                      /// PERSONAL DETAILS
                      buildSectionTitle("Personal Information"),

                      infoCard(
                        Icons.person_outline,
                        "Father Name",
                        v.fatherName,
                      ),

                      infoCard(Icons.calendar_month, "Date of Birth", v.dob),

                      infoCard(Icons.male, "Gender", v.gender),

                      infoCard(
                        Icons.favorite_outline,
                        "Marital Status",
                        v.maritalStatus,
                      ),

                      const SizedBox(height: 18),

                      /// ADDRESS
                      buildSectionTitle("Address Details"),

                      infoCard(
                        Icons.home_outlined,
                        "Address Line 1",
                        v.addressLine1,
                      ),

                      infoCard(Icons.location_city, "City", v.city),

                      infoCard(Icons.map_outlined, "State", v.state),

                      infoCard(Icons.pin_drop_outlined, "Pincode", v.pincode),

                      infoCard(Icons.public, "Country", v.country),

                      const SizedBox(height: 18),

                      /// PROFESSIONAL DETAILS
                      buildSectionTitle("Professional Details"),

                      infoCard(Icons.work_outline, "Occupation", v.occupation),

                      infoCard(
                        Icons.badge_outlined,
                        "Designation",
                        v.designation,
                      ),

                      infoCard(Icons.school_outlined, "Education", v.education),

                      infoCard(
                        Icons.currency_rupee,
                        "Annual Income",
                        v.annualIncome,
                      ),

                      infoCard(
                        Icons.account_balance_wallet,
                        "Monthly Income",
                        v.monthlyIncome,
                      ),

                      const SizedBox(height: 30),

                      /// UPDATE BUTTON
                      CustomLoadingButton(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AgentClientAddUpdateProfileScreen(
                                  clientId: widget.clientId,clientData: v
                                ),
                          ),
                        ),
                        isLoading: false,
                        text: 'Update Profile',
                      ),

                      const SizedBox(height: 30),
                    ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// EMPTY PROFILE
  Widget emptyProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 50),

          const SizedBox(height: 14),

          const Text(
            "Profile Not Completed",

            style: TextStyle(
              color: Colors.white,

              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "This client has not completed profile details yet.",

            textAlign: TextAlign.center,

            style: TextStyle(color: Colors.grey.shade400),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 54,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AgentClientAddUpdateProfileScreen(
                      clientId: widget.clientId,clientData: ClientCompleteData()
                  ),
            ),
          ),

              child: const Text(
                "Complete Profile",

                style: TextStyle(
                  color: Colors.white,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SECTION TITLE
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, left: 4),

      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(
          title,

          style: const TextStyle(
            color: Colors.white,

            fontSize: 18,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// INFO CARD
  Widget infoCard(IconData icon, String title, dynamic value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.white10),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: Colors.blueAccent),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),

                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value?.toString() ?? "-",

                  style: const TextStyle(
                    color: Colors.white,

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
}
