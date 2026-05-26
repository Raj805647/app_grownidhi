import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/individual_notification_response.dart';

class NotificationProvider extends BaseProvider {

  List<IndividualNotificationData> notificationList = [];

  bool isLoading = false;

  Future<void> fetchNotification() async {

    try {

      isLoading = true;
      notifyListeners();

      final response =
      await authRepository.individualNotification();

      print('notification response => ${response.isSuccess}');
      print('notification data => ${response.data}');
      print('notification error => ${response.error}');

      if (response.isSuccess == true &&
          response.data != null) {

        final List data =
            response.data['data'] ?? [];

        notificationList = data
            .map(
              (e) => IndividualNotificationData
              .fromJson(e),
        )
            .toList();

        notifyListeners();
      }

    } catch (error, stackTrace) {

      print("🔥 Notification Error => $error");
      print("📍 StackTrace => $stackTrace");

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }
}