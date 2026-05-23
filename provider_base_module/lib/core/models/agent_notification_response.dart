import 'package:base_module/base_module.dart';

class AgentNotificationResponse extends BaseModel {
  AgentNotificationResponse({
    super.status,
    super.message,
    this.totalNotifications,
    this.data,
  });

  AgentNotificationResponse.fromJson(dynamic json) {
    totalNotifications = json['total_notifications'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? totalNotifications;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['total_notifications'] = totalNotifications;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.currentPage,
    this.notificationData,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Data.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      notificationData = [];
      json['data'].forEach((v) {
        notificationData?.add(NotificationData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<NotificationData>? notificationData;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (notificationData != null) {
      map['data'] =
          notificationData?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

class Links {
  Links({
    this.url,
    this.label,
    this.page,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    page = json['page'];
    active = json['active'];
  }
  dynamic url;
  String? label;
  dynamic page;
  bool? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['page'] = page;
    map['active'] = active;
    return map;
  }
}

class NotificationData {
  NotificationData({
    this.id,
    this.userId,
    this.title,
    this.roleType,
    this.relatedId,
    this.relatedType,
    this.data,
    this.isRead,
    this.notificationSent,
    this.type,
    this.message,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  NotificationData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    roleType = json['role_type'];
    relatedId = json['related_id'];
    relatedType = json['related_type'];
    data = json['data'];
    isRead = json['is_read'];
    notificationSent = json['notification_sent'];
    type = json['type'];
    message = json['message'];
    date = json['date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  int? id;
  int? userId;
  String? title;
  String? roleType;
  dynamic relatedId;
  dynamic relatedType;
  dynamic data;
  bool? isRead;
  bool? notificationSent;
  String? type;
  String? message;
  dynamic date;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['role_type'] = roleType;
    map['related_id'] = relatedId;
    map['related_type'] = relatedType;
    map['data'] = data;
    map['is_read'] = isRead;
    map['notification_sent'] = notificationSent;
    map['type'] = type;
    map['message'] = message;
    map['date'] = date;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }
}
