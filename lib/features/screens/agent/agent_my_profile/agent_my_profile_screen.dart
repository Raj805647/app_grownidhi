import 'package:app_grownidhi/features/screens/agent/agent_my_profile/agent_my_profile_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/base_module.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../../../../widget/help_widget.dart';

class AgentMyProfileScreen extends StatefulWidget {
  const AgentMyProfileScreen({super.key});

  @override
  State<AgentMyProfileScreen> createState() => _AgentMyProfileScreenState();
}

class _AgentMyProfileScreenState extends State<AgentMyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentMyProfileProvider>().fetchAgentMyProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101426),
      body: Stack(
        children: [
          AppGradientBackground(),
          Consumer<AgentMyProfileProvider>(
            builder: (context, provider, child) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  /// APP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => provider.back(context),
                        child: Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => provider.navigateTo(
                          context,
                          RouteNames.agentMyProfileEditScreen,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.edit, color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  spaceHeight(30),

                  /// PROFILE CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(.12),
                      border: Border.all(color: Colors.black.withOpacity(.12)),
                    ),
                    child: Column(
                      children: [
                        /// IMAGE
                        spaceHeight(18),

                        /// NAME
                        Text(
                          provider.agentProfileData.fullName ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        spaceHeight(6),

                        Text(
                          provider.agentProfileData.designation ?? '',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),

                        spaceHeight(18),

                        /// BADGES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            badge("Verified"),
                            const SizedBox(width: 12),
                            badge("Top Performer"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  spaceHeight(28),

                  /// DETAILS
                  profileCard(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: provider.agentProfileData.email ?? '',
                  ),

                  profileCard(
                    icon: Icons.phone_android,
                    title: "Phone",
                    value: provider.agentProfileData.mobileNumber ?? '',

                  ),

                  profileCard(
                    icon: Icons.cake_outlined,
                    title: "Date Of Birth",
                    value: provider.agentProfileData.dob ?? '',
                  ),

                  profileCard(
                    icon: Icons.person_outline,
                    title: "Gender",
                    value: provider.agentProfileData.gender ?? '',
                  ),

                  profileCard(
                    icon: Icons.favorite_outline,
                    title: "Marital Status",
                    value: provider.agentProfileData.maritalStatus ?? '',
                  ),

                  profileCard(
                    icon: Icons.home_outlined,
                    title: "Address",
                    value: provider.agentProfileData.addressLine1 ?? '',
                  ),

                  profileCard(
                    icon: Icons.location_city_outlined,
                    title: "City",
                    value: provider.agentProfileData.city ?? '',
                  ),

                  profileCard(
                    icon: Icons.map_outlined,
                    title: "State",
                    value: provider.agentProfileData.state ?? '',
                  ),

                  profileCard(
                    icon: Icons.pin_drop_outlined,
                    title: "Pincode",
                    value: provider.agentProfileData.pincode ?? '',
                  ),

                  profileCard(
                    icon: Icons.flag_outlined,
                    title: "Country",
                    value: provider.agentProfileData.country ?? '',
                  ),

                  profileCard(
                    icon: Icons.work_outline,
                    title: "Occupation",
                    value: provider.agentProfileData.occupation ?? '',
                  ),

                  profileCard(
                    icon: Icons.badge_outlined,
                    title: "Designation",
                    value: provider.agentProfileData.designation ?? '',
                  ),

                  profileCard(
                    icon: Icons.timeline,
                    title: "Experience",
                    value: provider.agentProfileData.experience ?? '',
                  ),

                  profileCard(
                    icon: Icons.school_outlined,
                    title: "Education",
                    value: "MBA in Marketing",
                  ),

                  profileListCard(
                    icon: Icons.business_outlined,
                    title: "Company",
                    values: provider.agentProfileData.companies ?? [],
                  ),

                  profileListCard(
                    icon: Icons.shopping_bag_outlined,
                    title: "Product / Service",
                    values: provider.agentProfileData.products ?? [],
                  ),

                  profileCard(
                    icon: Icons.currency_rupee,
                    title: "Annual Income",
                    value: provider.agentProfileData.annualIncome ?? '',
                  ),

                  profileCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Monthly Income",
                    value: provider.agentProfileData.monthlyIncome ?? '',
                  ),

                  spaceHeight(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.18),
            Colors.black.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: Colors.black.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceHeight(6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
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

  /// LIST CARD
  Widget profileListCard({
    required IconData icon,
    required String title,
    required List<String> values,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.18),
            Colors.black.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: Colors.black.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),

              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: values.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(.15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
