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

class AgentMyProfileScreen extends StatelessWidget {
  const AgentMyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101426),
      body: Stack(
        children: [
         AppGradientBackground(),
          Consumer<AgentMyProfileProvider>(
            builder: (context, provider, child) =>  SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Column(
                children: [
                  /// APP BAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
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
                        onTap: ()=> provider.navigateTo(context, RouteNames.agentMyProfileEditScreen),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
            
                  const SizedBox(height: 30),
            
                  /// PROFILE CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(.12),
                      border: Border.all(
                        color: Colors.black.withOpacity(.12),
                      ),
                    ),
                    child: Column(
                      children: [
                        /// IMAGE
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              "https://i.pravatar.cc/300",
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 18),
            
                        /// NAME
                        const Text(
                          "Agent123",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            
                        const SizedBox(height: 6),
            
                        const Text(
                          "Senior Sales Agent",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
            
                        const SizedBox(height: 18),
            
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
            
                  const SizedBox(height: 28),
            
                  /// DETAILS
                  profileCard(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: "agent@gmail.com",
                  ),
            
                  profileCard(
                    icon: Icons.phone_android,
                    title: "Phone",
                    value: "+91 7863478569",
                  ),
            
                  profileCard(
                    icon: Icons.cake_outlined,
                    title: "Date Of Birth",
                    value: "12 March 1995",
                  ),
            
                  profileCard(
                    icon: Icons.person_outline,
                    title: "Gender",
                    value: "Male",
                  ),
            
                  profileCard(
                    icon: Icons.favorite_outline,
                    title: "Marital Status",
                    value: "Single",
                  ),
            
                  profileCard(
                    icon: Icons.home_outlined,
                    title: "Address",
                    value:
                    "221B Baker Street, New Delhi, India",
                  ),
            
                  profileCard(
                    icon: Icons.location_city_outlined,
                    title: "City",
                    value: "New Delhi",
                  ),
            
                  profileCard(
                    icon: Icons.map_outlined,
                    title: "State",
                    value: "Delhi",
                  ),
            
                  profileCard(
                    icon: Icons.pin_drop_outlined,
                    title: "Pincode",
                    value: "110001",
                  ),
            
                  profileCard(
                    icon: Icons.flag_outlined,
                    title: "Country",
                    value: "India",
                  ),
            
                  profileCard(
                    icon: Icons.work_outline,
                    title: "Occupation",
                    value: "Insurance Advisor",
                  ),
            
                  profileCard(
                    icon: Icons.badge_outlined,
                    title: "Designation",
                    value: "Senior Agent",
                  ),
            
                  profileCard(
                    icon: Icons.timeline,
                    title: "Experience",
                    value: "7 Years",
                  ),
            
                  profileCard(
                    icon: Icons.school_outlined,
                    title: "Education",
                    value: "MBA in Marketing",
                  ),
            
                  profileCard(
                    icon: Icons.business_outlined,
                    title: "Company",
                    value: "ABC Finance Pvt Ltd",
                  ),
            
                  profileCard(
                    icon: Icons.shopping_bag_outlined,
                    title: "Product / Service",
                    value: "Insurance & Financial Services",
                  ),
            
                  profileCard(
                    icon: Icons.currency_rupee,
                    title: "Annual Income",
                    value: "₹12,00,000",
                  ),
            
                  profileCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Monthly Income",
                    value: "₹1,00,000",
                  ),
            
                  const SizedBox(height: 30),
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
        border: Border.all(
          color: Colors.black.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
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
            child: Icon(
              icon,
              color: Colors.black,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
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