import 'package:app_grownidhi/features/screens/individual/individual_members/individual_members_provider.dart';
import 'package:base_module/core/models/individual_members_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';

class IndividualMemberDetailsScreen extends StatelessWidget {
  final IndividualMembersData membersData;

  const IndividualMemberDetailsScreen({
    super.key,
    required this.membersData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Background
          AppGradientBackground(),

          CustomScrollView(
            slivers: [

              /// App Bar
              Consumer<IndividualMembersProvider>(
                builder: (context, provider, child) =>  CustomSliverAppBar(
                  title: "Member Details",
                  actions: [
                    GestureDetector(
                      onTap: () {
                        showDeleteMemberDialog(
                          context: context,
                          onDelete: () {
                            provider
                                .individualDeleteMember(
                              context,
                              membersData.id ?? 0,
                            );
                            provider.back(context);
                          }
                        );
                      },

                      child: Container(
                        padding: const EdgeInsets.all(
                          8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(
                            0.14,
                          ),

                          borderRadius:
                          BorderRadius.circular(12),
                        ),

                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    children: [

                      /// Hero Profile Card
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(32),

                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,

                            colors: [
                              const Color(0xff6C63FF)
                                  .withOpacity(0.28),

                              Colors.white
                                  .withOpacity(0.06),
                            ],
                          ),

                          border: Border.all(
                            color: Colors.white12,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xff6C63FF,
                              ).withOpacity(0.16),

                              blurRadius: 30,
                              spreadRadius: 2,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [

                            /// Avatar
                            Container(
                              padding:
                              const EdgeInsets.all(4),

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                gradient:
                                const LinearGradient(
                                  colors: [
                                    Color(0xff6C63FF),
                                    Color(0xff9D97FF),
                                  ],
                                ),
                              ),

                              child: CircleAvatar(
                                radius: 42,
                                backgroundColor:
                                const Color(
                                  0xff1B2230,
                                ),

                                child: Text(
                                  membersData.name
                                      ?.substring(
                                      0, 1)
                                      .toUpperCase() ??
                                      '?',

                                  style:
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            /// Name
                            Text(
                              membersData.name ?? '',

                              textAlign:
                              TextAlign.center,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight:
                                FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// Relationship Badge
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),

                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    30),

                                color: Colors.white
                                    .withOpacity(0.10),
                              ),

                              child: Text(
                                membersData.relationship ??
                                    '',

                                style:
                                const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            /// Quick Stats
                            Row(
                              children: [

                                Expanded(
                                  child: buildQuickCard(
                                    icon:
                                    Icons.person,
                                    title: "Gender",
                                    value:
                                    membersData.gender ??
                                        '',
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: buildQuickCard(
                                    icon:
                                    Icons.cake,
                                    title: "DOB",
                                    value: membersData
                                        .dob
                                        ?.split(
                                        'T')
                                        .first ??
                                        '',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// Information Grid
                      GridView(
                        shrinkWrap: true,

                        physics:
                        const NeverScrollableScrollPhysics(),

                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 1.25,
                        ),

                        children: [

                          buildGlassInfoCard(
                            icon: Icons.work_outline,
                            title: "Occupation",
                            value:
                            membersData.occupation ??
                                '',
                          ),

                          buildGlassInfoCard(
                            icon:
                            Icons.currency_rupee,
                            title: "Income",
                            value:
                            "₹ ${membersData.annualIncome ?? ''}",
                          ),

                          buildGlassInfoCard(
                            icon:
                            Icons.phone_outlined,
                            title: "Contact",
                            value: membersData
                                .contactNumber ??
                                '',
                          ),

                          buildGlassInfoCard(
                            icon:
                            Icons.family_restroom,
                            title: "Dependent",
                            value: membersData
                                .isDependent ==
                                true
                                ? "Yes"
                                : "No",
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      /// Personal Information
                      buildSectionContainer(
                        title: "Personal Information",

                        child: Column(
                          children: [

                            buildTile(
                              icon:
                              Icons.badge_outlined,
                              title: "PAN Number",
                              value:
                              membersData.pan ??
                                  '',
                            ),

                            buildTile(
                              icon:
                              Icons.credit_card,
                              title:
                              "Aadhaar Number",
                              value: membersData
                                  .aadharNumber ??
                                  '',
                            ),

                            buildTile(
                              icon:
                              Icons.email_outlined,
                              title: "Email",
                              value:
                              membersData.email ??
                                  '',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// Notes
                      if (membersData.notes != null &&
                          membersData.notes!
                              .isNotEmpty)
                        buildSectionContainer(
                          title: "Notes",

                          child: Text(
                            membersData.notes ?? '',

                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.7,
                            ),
                          ),
                        ),

                      const SizedBox(height: 22),

                      /// Documents
                      if (membersData.documents !=
                          null &&
                          membersData
                              .documents!.isNotEmpty)
                        buildSectionContainer(
                          title: "Documents",

                          child: GridView.builder(
                            shrinkWrap: true,

                            physics:
                            const NeverScrollableScrollPhysics(),

                            itemCount: membersData
                                .documents!.length,

                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1,
                            ),

                            itemBuilder:
                                (context, index) {

                              final image =
                                  membersData
                                      .documents?[
                                  index] ??
                                      '';

                              return ClipRRect(
                                borderRadius:
                                BorderRadius
                                    .circular(18),

                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,

                                  errorBuilder:
                                      (_, __, ___) {
                                    return Container(
                                      color:
                                      Colors.white10,

                                      child:
                                      const Icon(
                                        Icons
                                            .broken_image,
                                        color: Colors
                                            .white54,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQuickCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        color: Colors.white.withOpacity(0.08),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),

          const SizedBox(height: 8),

          Text(
            title,

            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGlassInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        color: Colors.white.withOpacity(0.06),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),

          const SizedBox(height: 12),

          Text(
            title,

            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,

            textAlign: TextAlign.center,

            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionContainer({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),

        color: Colors.white.withOpacity(0.05),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
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