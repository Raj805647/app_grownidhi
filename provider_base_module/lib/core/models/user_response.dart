import 'package:base_module/base_module.dart';

class UserResponse extends BaseModel {
  UserResponse({
      super.success,
      super.message,
      this.data,});

  UserResponse.fromJson(dynamic json) {
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  UserData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class UserData {
  UserData({
      this.id, 
      this.name, 
      this.mobile, 
      this.email, 
      this.role, 
      this.token,});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    role = json['role'];
    token = json['token'];
  }
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? role;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['role'] = role;
    map['token'] = token;
    return map;
  }

}