import 'package:app_grownidhi/features/screens/individual/individivual_add_member/individual_add_member_screen.dart';
import 'package:app_grownidhi/features/screens/individual/individual_members/individual_members_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/help_widget.dart';
import 'individual_member_details_screen.dart';

class IndividualMembersScreen extends StatefulWidget {
  const IndividualMembersScreen({super.key});

  @override
  State<IndividualMembersScreen> createState() =>
      _IndividualMembersScreenState();
}

class _IndividualMembersScreenState extends State<IndividualMembersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(
      () => context.read<IndividualMembersProvider>().fetchIndividualMember(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndividualAddMemberScreen()),
        ),

        backgroundColor: const Color(0xff6C63FF),

        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          /// Background
          AppGradientBackground(),

          Consumer<IndividualMembersProvider>(
            builder: (context, provider, child) {
              /// Loading
              if (provider.isLoad) {
                return const Center(child: CircularProgressIndicator());
              }

              return CustomScrollView(
                slivers: [
                  /// App Bar
                  CustomSliverAppBar(title: 'Family Members'),

                  /// Empty State
                  if (provider.individualMembersData.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  /// List
                  else
                    SliverPadding(
                      padding: const EdgeInsets.all(16),

                      sliver: SliverList.builder(
                        itemCount: provider.individualMembersData.length,

                        itemBuilder: (context, index) {
                          final item = provider.individualMembersData[index];

                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IndividualMemberDetailsScreen(
                                      membersData: item,
                                    ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),

                              padding: const EdgeInsets.all(14),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),

                                color: Colors.white.withOpacity(0.06),

                                border: Border.all(color: Colors.white10),
                              ),

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  /// Avatar
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.white12,

                                    child: Text(
                                      item.name
                                              ?.substring(0, 1)
                                              .toUpperCase() ??
                                          '?',

                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  /// Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        /// Top Row
                                        Row(
                                          children: [
                                            /// Name
                                            Expanded(
                                              child: Text(
                                                item.name ?? '',

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,

                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                            /// Delete Button
                                            GestureDetector(
                                              onTap: () {
                                                showDeleteMemberDialog(
                                                  context: context,
                                                  onDelete: () => provider
                                                      .individualDeleteMember(
                                                        context,
                                                        item.id ?? 0,
                                                      ),
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
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 4),

                                        /// Relationship + Gender
                                        Row(
                                          children: [
                                            Text(
                                              item.relationship ?? '',

                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 13,
                                              ),
                                            ),

                                            const SizedBox(width: 10),

                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),

                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),

                                                color: Colors.blue.withOpacity(
                                                  0.18,
                                                ),
                                              ),

                                              child: Text(
                                                item.gender ?? '',

                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        /// Contact
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              color: Colors.white54,
                                              size: 15,
                                            ),

                                            const SizedBox(width: 6),

                                            Expanded(
                                              child: Text(
                                                item.contactNumber ?? '',

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,

                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        /// Occupation
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.work_outline,
                                              color: Colors.white54,
                                              size: 15,
                                            ),

                                            const SizedBox(width: 6),

                                            Expanded(
                                              child: Text(
                                                item.occupation ?? '',

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,

                                                style: const TextStyle(
                                                  color: Colors.white,
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
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 95,

            child: Text(
              title,

              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ),

          Expanded(
            child: Text(
              value,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
