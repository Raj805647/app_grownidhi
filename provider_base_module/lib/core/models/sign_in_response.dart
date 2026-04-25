import 'package:base_module/base_module.dart';

class SignInResponse extends BaseModel {
  SignInResponse({
    super.status,
    super.message,
    this.data,
  });

  SignInResponse.fromJson(dynamic json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  UserData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class UserData {
  UserData({
    this.token,
    this.role,
    this.id,
  });

  UserData.fromJson(dynamic json) {
    token = json['token'];
    role = json['role'];
    id = json['id'];
  }
  String? token;
  String? role;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['role'] = role;
    map['id'] = id;
    return map;
  }
}
