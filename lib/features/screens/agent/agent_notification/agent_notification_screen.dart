import 'package:app_grownidhi/features/screens/agent/agent_notification/agent_notification_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_textfield.dart';

class AgentNotificationScreen extends StatefulWidget {
  const AgentNotificationScreen({super.key});

  @override
  State<AgentNotificationScreen> createState() =>
      _AgentNotificationScreenState();
}

class _AgentNotificationScreenState
    extends State<AgentNotificationScreen> {

  @override
  void initState() {
    Future.microtask(
          () => context
          .read<AgentNotificationProvider>()
          .fetchAgentNotification(),
    );
    super.initState();
  }

  Color getTypeColor(String? type) {
    switch (type) {
      case "kyc":
        return Colors.orange;
      case "loan":
        return Colors.green;
      case "insurance":
        return Colors.blueAccent;
      default:
        return Colors.purpleAccent;
    }
  }

  IconData getTypeIcon(String? type) {
    switch (type) {
      case "kyc":
        return Icons.verified_user_rounded;
      case "loan":
        return Icons.account_balance_wallet;
      case "insurance":
        return Icons.health_and_safety;
      default:
        return Icons.notifications_active_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
      CustomAppBar(title: 'Agent Notification'),

      body: Stack(
        children: [

          /// Background
          const AppGradientBackground(),

          /// Content
          Consumer<AgentNotificationProvider>(
            builder: (context, provider, child) {

              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (provider.notificationData.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.notifications_off,
                        size: 70,
                        color: Colors.white
                            .withOpacity(0.5),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "No Notifications Found",
                        style: TextStyle(
                          color: Colors.white
                              .withOpacity(0.7),
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),

                itemCount:
                provider.notificationData.length,

                separatorBuilder: (_, __) =>
                const SizedBox(height: 14),

                itemBuilder: (context, index) {

                  final item =
                  provider.notificationData[index];

                  final color =
                  getTypeColor(item.type);

                  return Container(
                    padding:
                    const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.10),

                      borderRadius:
                      BorderRadius.circular(24),

                      border: Border.all(
                        color: item.isRead == false
                            ? color.withOpacity(0.45)
                            : Colors.white
                            .withOpacity(0.08),
                        width: 1,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.08),
                          blurRadius: 10,
                          offset:
                          const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// Icon
                        Container(
                          padding:
                          const EdgeInsets.all(
                              14),

                          decoration: BoxDecoration(
                            color: color.withOpacity(
                                0.15),

                            borderRadius:
                            BorderRadius
                                .circular(18),
                          ),

                          child: Icon(
                            getTypeIcon(item.type),
                            color: color,
                            size: 26,
                          ),
                        ),

                        const SizedBox(width: 14),

                        /// Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              /// Top
                              Row(
                                children: [

                                  Expanded(
                                    child: Text(
                                      item.title ??
                                          "",
                                      style:
                                      const TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                      ),
                                    ),
                                  ),

                                  if (item.isRead ==
                                      false)
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration:
                                      BoxDecoration(
                                        color: color,
                                        shape: BoxShape
                                            .circle,
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(
                                  height: 8),

                              /// Message
                              Text(
                                item.message ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),

                              const SizedBox(
                                  height: 12),

                              /// Bottom
                              Row(
                                children: [

                                  Container(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),

                                    decoration:
                                    BoxDecoration(
                                      color: color
                                          .withOpacity(
                                          0.14),

                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          30),
                                    ),

                                    child: Text(
                                      item.type
                                          ?.toUpperCase() ??
                                          "",
                                      style:
                                      TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  Icon(
                                    Icons.access_time,
                                    size: 15,
                                    color: Colors
                                        .white
                                        .withOpacity(
                                        0.5),
                                  ),

                                  const SizedBox(
                                      width: 5),

                                  Text(
                                    formatDate(item.createdAt ??
                                        ""),
                                    style:
                                    TextStyle(
                                      color: Colors
                                          .white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}