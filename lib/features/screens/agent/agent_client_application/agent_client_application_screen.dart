import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/client_application_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agent_client_application_details_screen.dart';

class AgentClientApplicationScreen extends StatelessWidget {
  final List<ClientApplicationData> clientList;

  const AgentClientApplicationScreen({
    super.key,
    required this.clientList,
  });

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.redAccent;
      case "pending":
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Client Applications'),
      body: Stack(
        children: [
          const AppGradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Column(
                children: [

                  /// Top Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff1E3C72),
                          Color(0xff2A5298),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.description_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "Total Applications",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "${clientList.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// List
                  Expanded(
                    child: ListView.separated(
                      itemCount: clientList.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 16),
                      itemBuilder: (context, index) {

                        final item = clientList[index];

                        return  InkWell(
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AgentClientApplicationDetailsScreen(clientDetails: item),)),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.30),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                              ),
                            ),
                            child: Column(
                              children: [

                                /// Top Row
                                Row(
                                  children: [

                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor:
                                      Colors.white.withOpacity(0.15),
                                      child: Text(
                                        item.client?.name
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                            "N",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            item.client?.name ?? "",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          const SizedBox(height: 3),

                                          Text(
                                            item.product?.productName ?? "",
                                            style: TextStyle(
                                              color:
                                              Colors.white.withOpacity(0.75),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
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
                                          color: item.status == "pending"
                                              ? Colors.orange
                                              : Colors.greenAccent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                /// Bottom Info
                                Wrap(
                                  spacing: 14,
                                  runSpacing: 10,
                                  children: [

                                    _miniInfo(
                                      Icons.category_rounded,
                                      item.product?.category ?? "-",
                                    ),

                                    _miniInfo(
                                      Icons.phone,
                                      item.client?.phone ?? "-",
                                    ),

                                    _miniInfo(
                                      Icons.email_outlined,
                                      item.client?.email ?? "-",
                                    ),

                                    _miniInfo(
                                      Icons.calendar_month,
                                      item.submittedDate ?? "-",
                                    ),
                                  ],
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniInfo(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Icon(
          icon,
          size: 15,
          color: Colors.greenAccent,
        ),

        const SizedBox(width: 5),

        SizedBox(
          width: 110,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}