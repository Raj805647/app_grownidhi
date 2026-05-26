import 'package:base_module/base_module.dart';

class IndividualNotificationResponse extends BaseModel {
  IndividualNotificationResponse({
      super.status,
      super.message,
      this.totalNotifications, 
      this.data,});

  IndividualNotificationResponse.fromJson(dynamic json) {
    totalNotifications = json['total_notifications'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(IndividualNotificationData.fromJson(v));
      });
    }
  }
  int? totalNotifications;
  List<IndividualNotificationData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['total_notifications'] = totalNotifications;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class IndividualNotificationData {
  IndividualNotificationData({
      this.notificationId, 
      this.title, 
      this.message, 
      this.type, 
      this.roleType, 
      this.applicationId, 
      this.applicationNo, 
      this.isRead, 
      this.status, 
      this.date, 
      this.createdAt,});

  IndividualNotificationData.fromJson(dynamic json) {
    notificationId = json['notification_id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    roleType = json['role_type'];
    applicationId = json['application_id'];
    applicationNo = json['application_no'];
    isRead = json['is_read'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
  }
  int? notificationId;
  String? title;
  String? message;
  String? type;
  String? roleType;
  dynamic applicationId;
  String? applicationNo;
  bool? isRead;
  String? status;
  dynamic date;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notification_id'] = notificationId;
    map['title'] = title;
    map['message'] = message;
    map['type'] = type;
    map['role_type'] = roleType;
    map['application_id'] = applicationId;
    map['application_no'] = applicationNo;
    map['is_read'] = isRead;
    map['status'] = status;
    map['date'] = date;
    map['created_at'] = createdAt;
    return map;
  }

}