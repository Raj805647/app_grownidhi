import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_textfield.dart';
import '../../../../widget/ui_design.dart';
import 'individual_profile_details_provider.dart';

class IndividualProfileDetailsScreen extends StatefulWidget {
  const IndividualProfileDetailsScreen({super.key});

  @override
  State<IndividualProfileDetailsScreen> createState() =>
      _IndividualProfileDetailsScreenState();
}

class _IndividualProfileDetailsScreenState
    extends State<IndividualProfileDetailsScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<IndividualProfileDetailsProvider>()
          .fetchAgentDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<IndividualProfileDetailsProvider>(
      builder: (context, provider, child) {

        final profile = provider.userProfileData;

        return Scaffold(
          backgroundColor: const Color(0xffEEF4FF),

          body: Stack(
            children: [

              /// BACKGROUND
              const AppGradientBackground(),

              /// BODY
              provider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff5B4DFF),
                ),
              )

                  : SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),

                  slivers: [

                    /// APP BAR
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      pinned: true,
                      expandedHeight: 80,

                      leading: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 10,
                        ),

                        child: InkWell(
                          onTap: () => Navigator.pop(context),

                          borderRadius: BorderRadius.circular(16),

                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: const [

                          Text(
                            "Profile Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Manage your personal information",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// BODY
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(1),

                        child: Column(
                          children: [

                            /// PROFILE CARD
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),

                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(32),

                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,

                                  colors: [
                                    Color(0xff5B4DFF),
                                    Color(0xff7B61FF),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff5B4DFF)
                                        .withOpacity(0.25),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [

                                  /// AVATAR
                                  Container(
                                    height: 90,
                                    width: 90,

                                    decoration: BoxDecoration(
                                      color: Colors.white
                                          .withOpacity(0.15),

                                      shape: BoxShape.circle,

                                      border: Border.all(
                                        color: Colors.white
                                            .withOpacity(0.25),
                                        width: 2,
                                      ),
                                    ),

                                    child: Center(
                                      child: Text(
                                        profile?.fullName
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                            "U",

                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  Text(
                                    profile?.fullName ?? "",
                                    textAlign: TextAlign.center,

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    profile?.email ?? "",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  Row(
                                    children: [

                                      Expanded(
                                        child: _topInfoCard(
                                          Icons.phone,
                                          "Mobile",
                                          profile?.mobileNumber ?? "-",
                                        ),
                                      ),

                                      const SizedBox(width: 14),

                                      Expanded(
                                        child: _topInfoCard(
                                          Icons.work_outline,
                                          "Occupation",
                                          profile?.occupation ?? "-",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            /// PERSONAL INFO
                            _sectionTitle("Personal Information"),

                            const SizedBox(height: 16),

                            _profileTile(
                              Icons.person_outline,
                              "Father Name",
                              profile?.fatherName ?? "-",
                            ),

                            _profileTile(
                              Icons.calendar_month,
                              "Date of Birth",
                              formatDate(profile?.dob ?? "-"),
                            ),

                            _profileTile(
                              Icons.male,
                              "Gender",
                              profile?.gender ?? "-",
                            ),

                            _profileTile(
                              Icons.favorite_border,
                              "Marital Status",
                              profile?.maritalStatus ?? "-",
                            ),

                            const SizedBox(height: 24),

                            /// ADDRESS
                            _sectionTitle("Address Information"),

                            const SizedBox(height: 16),

                            _profileTile(
                              Icons.location_on_outlined,
                              "Address Line 1",
                              profile?.addressLine1 ?? "-",
                            ),

                            _profileTile(
                              Icons.location_city_outlined,
                              "City",
                              profile?.city ?? "-",
                            ),

                            _profileTile(
                              Icons.map_outlined,
                              "State",
                              profile?.state ?? "-",
                            ),

                            _profileTile(
                              Icons.pin_drop_outlined,
                              "Pincode",
                              profile?.pincode ?? "-",
                            ),

                            _profileTile(
                              Icons.flag_outlined,
                              "Country",
                              profile?.country ?? "-",
                            ),

                            const SizedBox(height: 24),

                            /// PROFESSIONAL INFO
                            _sectionTitle("Professional Information"),

                            const SizedBox(height: 16),

                            _profileTile(
                              Icons.work_outline,
                              "Occupation",
                              profile?.occupation ?? "-",
                            ),

                            _profileTile(
                              Icons.badge_outlined,
                              "Designation",
                              profile?.designation ?? "-",
                            ),

                            _profileTile(
                              Icons.school_outlined,
                              "Education",
                              profile?.education ?? "-",
                            ),

                            _profileTile(
                              Icons.currency_rupee,
                              "Annual Income",
                              profile?.annualIncome ?? "-",
                            ),

                            _profileTile(
                              Icons.payments_outlined,
                              "Monthly Income",
                              profile?.monthlyIncome ?? "-",
                            ),

                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// SECTION TITLE
  Widget _sectionTitle(String title) {
    return Row(
      children: [

        Container(
          height: 20,
          width: 5,

          decoration: BoxDecoration(
            color: const Color(0xff5B4DFF),
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// INFO CARD
  Widget _topInfoCard(
      IconData icon,
      String title,
      String value,
      ) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
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

  /// PROFILE TILE
  Widget _profileTile(
      IconData icon,
      String title,
      String value,
      ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff5B4DFF),
                  Color(0xff7B61FF),
                ],
              ),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
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
}