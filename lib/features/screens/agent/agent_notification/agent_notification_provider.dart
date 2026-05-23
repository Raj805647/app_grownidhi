import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_notification_response.dart';

class AgentNotificationProvider extends BaseProvider {
  bool isLoading = false;
  List<NotificationData> notificationData = [];

  Future<void> fetchAgentNotification() async {
    try {
      isLoading = false;
      notifyListeners();

      final response = await authRepository.agentNotificationData();
      print('adfhvdsfadsfdsa');
      print(response.isSuccess);
      print(response.data);
      print(response.error);

      if (response.isSuccess == true) {
        final List rawList = response.data['data']['data'] ?? [];
        notificationData = rawList
            .map((e) => NotificationData.fromJson(e))
            .toList();
        notifyListeners();
      }
    } catch (error) {
      print(('adkfbkdsbfksb+> $error'));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
