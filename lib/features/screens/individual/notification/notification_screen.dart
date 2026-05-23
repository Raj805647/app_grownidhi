import 'package:app_grownidhi/features/screens/individual/notification/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(()=> context.read<NotificationProvider>().fetchNotification());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
