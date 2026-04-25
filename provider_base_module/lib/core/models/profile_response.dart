import 'package:base_module/base_module.dart';

class ProfileResponse extends BaseModel{
  ProfileResponse({
      super.status,
      super.message,
      this.data,});

  ProfileResponse.fromJson(dynamic json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  ProfileData? data;

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

class ProfileData {
  ProfileData({
      this.id, 
      this.role, 
      this.image, 
      this.name, 
      this.headline, 
      this.email, 
      this.bio, 
      this.gender, 
      this.document, 
      this.emailVerifiedAt, 
      this.facebook, 
      this.twitter,
      this.linkedin, 
      this.website, 
      this.github, 
      this.approveStatus, 
      this.loginAs, 
      this.wallet, 
      this.createdAt, 
      this.updatedAt,});

  ProfileData.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    image = json['image'];
    name = json['name'];
    headline = json['headline'];
    email = json['email'];
    bio = json['bio'];
    gender = json['gender'];
    document = json['document'];
    emailVerifiedAt = json['email_verified_at'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    website = json['website'];
    github = json['github'];
    approveStatus = json['approve_status'];
    loginAs = json['login_as'];
    wallet = json['wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? role;
  String? image;
  String? name;
  String? headline;
  String? email;
  String? bio;
  String? gender;
  String? document;
  dynamic emailVerifiedAt;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? website;
  dynamic github;
  String? approveStatus;
  dynamic loginAs;
  int? wallet;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role'] = role;
    map['image'] = image;
    map['name'] = name;
    map['headline'] = headline;
    map['email'] = email;
    map['bio'] = bio;
    map['gender'] = gender;
    map['document'] = document;
    map['email_verified_at'] = emailVerifiedAt;
    map['facebook'] = facebook;
    map['twitter'] = twitter;
    map['linkedin'] = linkedin;
    map['website'] = website;
    map['github'] = github;
    map['approve_status'] = approveStatus;
    map['login_as'] = loginAs;
    map['wallet'] = wallet;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}