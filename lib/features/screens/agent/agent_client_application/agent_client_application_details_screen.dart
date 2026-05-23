import 'dart:math';

import 'package:app_grownidhi/widget/help_widget.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/client_application_response.dart';
import 'package:flutter/material.dart';

class AgentClientApplicationDetailsScreen
    extends StatelessWidget {

  final ClientApplicationData clientDetails;

  const AgentClientApplicationDetailsScreen({
    super.key,
    required this.clientDetails,
  });

  @override
  Widget build(BuildContext context) {

    final dynamicData =
        clientDetails.applicationData ?? {};

    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      body: Stack(
        children: [

          /// Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0B3D2E),
                  Color(0xff14532D),
                  Color(0xff0F172A),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                /// Appbar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [

                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius:
                        BorderRadius.circular(14),
                        child: Container(
                          padding:
                          const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.10),
                            borderRadius:
                            BorderRadius.circular(
                                14),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Text(
                        "Application Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Body
                Expanded(
                  child: ListView(
                    padding:
                    const EdgeInsets.all(16),
                    children: [

                      /// Profile Card
                      Container(
                        padding:
                        const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.08),
                          borderRadius:
                          BorderRadius.circular(
                              28),
                          border: Border.all(
                            color: Colors.white
                                .withOpacity(0.08),
                          ),
                        ),
                        child: Column(
                          children: [

                            CircleAvatar(
                              radius: 38,
                              backgroundColor:
                              Colors.white
                                  .withOpacity(
                                  0.15),
                              child: Text(
                                clientDetails
                                    .client
                                    ?.name
                                    ?.substring(
                                    0, 1)
                                    .toUpperCase() ??
                                    "N",
                                style:
                                const TextStyle(
                                  color:
                                  Colors.white,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            Text(
                              clientDetails
                                  .client
                                  ?.name ??
                                  "",
                              style:
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              clientDetails
                                  .product
                                  ?.productName ??
                                  "",
                              style: TextStyle(
                                color: Colors.white
                                    .withOpacity(
                                    0.70),
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Row(
                              children: [

                                Expanded(
                                  child: _topInfoCard(
                                    Icons.phone,
                                    "Phone",
                                    clientDetails
                                        .client
                                        ?.phone ??
                                        "-",
                                  ),
                                ),

                                const SizedBox(
                                    width: 12),

                                Expanded(
                                  child: _topInfoCard(
                                    Icons.email,
                                    "Email",
                                    clientDetails
                                        .client
                                        ?.email ??
                                        "-",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [

                                Expanded(
                                  child: _topInfoCard(
                                    Icons
                                        .category_rounded,
                                    "Category",
                                    clientDetails
                                        .product
                                        ?.category ??
                                        "-",
                                  ),
                                ),

                                const SizedBox(
                                    width: 12),

                                Expanded(
                                  child: _topInfoCard(
                                    Icons
                                        .calendar_month,
                                    "Submitted",
                                    clientDetails
                                        .submittedDate ??
                                        "-",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Dynamic Data Title
                      const Text(
                        "Application Information",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Dynamic Fields
                      ...dynamicData.entries.map(
                            (entry) {
                              if (entry.value != null &&
                                  entry.value
                                      .toString()
                                      .toLowerCase()
                                      .startsWith('uploads/forms/')) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      entry.key,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    spaceHeight(10),
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                      child: Image.network(
                                        "${AppConfig.imageUrl}/${entry.value}",
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,

                                        errorBuilder:
                                            (context, error, stackTrace) {

                                          return Container(
                                            height: 120,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.05),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  14),
                                            ),
                                            child: const Text(
                                              "Image not found",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }


                          return Container(
                            margin:
                            const EdgeInsets.only(
                                bottom: 14),
                            padding:
                            const EdgeInsets.all(
                                16),
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.08),
                              borderRadius:
                              BorderRadius
                                  .circular(20),
                              border: Border.all(
                                color: Colors.white
                                    .withOpacity(
                                    0.05),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [

                                Container(
                                  padding:
                                  const EdgeInsets
                                      .all(10),
                                  decoration:
                                  BoxDecoration(
                                    color: Colors
                                        .greenAccent
                                        .withOpacity(
                                        0.15),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        14),
                                  ),
                                  child: const Icon(
                                    Icons
                                        .description_outlined,
                                    color: Colors
                                        .greenAccent,
                                    size: 20,
                                  ),
                                ),

                                const SizedBox(
                                    width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [

                                      Text(
                                        entry.key
                                            .replaceAll(
                                            "_",
                                            " ")
                                            .toUpperCase(),
                                        style:
                                        TextStyle(
                                          color: Colors
                                              .white
                                              .withOpacity(
                                              0.60),
                                          fontSize: 11,
                                          fontWeight:
                                          FontWeight
                                              .w600,
                                          letterSpacing:
                                          1,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 6),

                                      Text(
                                        entry.value
                                            .toString(),
                                        style:
                                        const TextStyle(
                                          color: Colors
                                              .white,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight
                                              .w600,
                                        ),
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
    );
  }

  Widget _topInfoCard(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: Colors.greenAccent,
            size: 20,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.60),
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
}