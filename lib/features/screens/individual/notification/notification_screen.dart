import 'package:app_grownidhi/features/screens/individual/notification/notification_provider.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:base_module/core/models/individual_notification_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_textfield.dart';
import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<NotificationProvider>().fetchNotification(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          AppGradientBackground(),

          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.notificationList.isEmpty) {
                return Center(
                  child: buildEmptyState(
                    title: "No Notifications",
                    subTitle: "You don't have any notifications yet.",
                    icon: Icons.notifications_off_outlined,
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  /// APP BAR
                  CustomSliverAppBar(title: 'Notifications'),

                  /// LIST
                  SliverPadding(
                    padding: const EdgeInsets.all(16),

                    sliver: SliverList.separated(
                      itemCount: provider.notificationList.length,

                      separatorBuilder: (_, __) => const SizedBox(height: 14),

                      itemBuilder: (context, index) {
                        final item = provider.notificationList[index];

                        return _notificationCard(item);
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

  Widget _notificationCard(IndividualNotificationData item) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            item.isRead == true
                ? Colors.white.withOpacity(0.05)
                : Colors.blue.withOpacity(0.16),

            item.isRead == true
                ? Colors.white.withOpacity(0.03)
                : Colors.purple.withOpacity(0.08),
          ],
        ),

        border: Border.all(
          color: item.isRead == true
              ? Colors.white10
              : Colors.blue.withOpacity(0.3),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// ICON
          Container(
            height: 52,
            width: 52,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              color: _getNotificationColor(item.type ?? '').withOpacity(0.15),
            ),

            child: Icon(
              _getNotificationIcon(item.type ?? ''),
              color: _getNotificationColor(item.type ?? ''),
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// TITLE + STATUS
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title ?? '',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (item.isRead == false)
                      Container(
                        height: 10,
                        width: 10,

                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                /// MESSAGE
                Text(
                  item.message ?? '',

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 14),

                /// BOTTOM ROW
                Row(
                  children: [
                    /// TYPE CHIP
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: _getNotificationColor(
                          item.type ?? '',
                        ).withOpacity(0.15),

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        (item.type ?? '').replaceAll('_', ' ').toUpperCase(),

                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getNotificationColor(item.type ?? ''),
                        ),
                      ),
                    ),

                    const Spacer(),

                    /// DATE
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: Colors.white.withOpacity(0.5),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          formatDate(item.createdAt),

                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),

                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'kyc':
        return Icons.verified_user_outlined;

      case 'application_submitted':
        return Icons.description_outlined;

      case 'due_reminder':
        return Icons.alarm_outlined;

      case 'renewal_reminder':
        return Icons.refresh_outlined;

      case 'reminder':
        return Icons.notifications_active_outlined;

      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type.toLowerCase()) {
      case 'kyc':
        return Colors.greenAccent;

      case 'application_submitted':
        return Colors.blueAccent;

      case 'due_reminder':
        return Colors.orangeAccent;

      case 'renewal_reminder':
        return Colors.purpleAccent;

      case 'reminder':
        return Colors.cyanAccent;

      default:
        return Colors.white;
    }
  }
}
