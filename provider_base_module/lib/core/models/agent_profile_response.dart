import 'package:base_module/base_module.dart';

class AgentProfileResponse extends BaseModel {
  AgentProfileResponse({
      super.status,
      super.message,
      this.data,});

  AgentProfileResponse.fromJson(dynamic json) {
    data = json['data'] != null ? AgentProfileData.fromJson(json['data']) : null;
  }
  AgentProfileData? data;

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

class AgentProfileData {
  AgentProfileData({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.type, 
      this.otp, 
      this.otpExpireAt, 
      this.token, 
      this.googleId, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.status, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.agentId, 
      this.deletedAt, 
      this.profileImage,});

  AgentProfileData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    otp = json['otp'];
    otpExpireAt = json['otp_expire_at'];
    token = json['token'];
    googleId = json['google_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    agentId = json['agent_id'];
    deletedAt = json['deleted_at'];
    profileImage = json['profile_image'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic otp;
  dynamic otpExpireAt;
  dynamic token;
  dynamic googleId;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  bool? status;
  dynamic createdBy;
  int? updatedBy;
  dynamic deletedBy;
  dynamic agentId;
  dynamic deletedAt;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['type'] = type;
    map['otp'] = otp;
    map['otp_expire_at'] = otpExpireAt;
    map['token'] = token;
    map['google_id'] = googleId;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['deleted_by'] = deletedBy;
    map['agent_id'] = agentId;
    map['deleted_at'] = deletedAt;
    map['profile_image'] = profileImage;
    return map;
  }

}