import 'package:base_module/base_module.dart';

class IndividualKycDataResponse extends BaseModel {
  IndividualKycDataResponse({
      super.status,
      super.message,
      this.data,});

  IndividualKycDataResponse.fromJson(dynamic json) {
    data = json['data'] != null ? IndividualKYCData.fromJson(json['data']) : null;
  }
  IndividualKYCData? data;

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

class IndividualKYCData {
  IndividualKYCData({
      this.id, 
      this.userId, 
      this.fullName, 
      this.panNumber, 
      this.aadharNumber, 
      this.accountHolderName, 
      this.bankName, 
      this.accountNumber, 
      this.ifscCode, 
      this.branchName, 
      this.kycStatus, 
      this.panFileFront, 
      this.panFileBack, 
      this.aadharFrontFile, 
      this.aadharBackFile, 
      this.selfieFile, 
      this.user, 
      this.createdAt, 
      this.updatedAt,});

  IndividualKYCData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    accountHolderName = json['account_holder_name'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    branchName = json['branch_name'];
    kycStatus = json['kyc_status'];
    panFileFront = json['pan_file_front'];
    panFileBack = json['pan_file_back'];
    aadharFrontFile = json['aadhar_front_file'];
    aadharBackFile = json['aadhar_back_file'];
    selfieFile = json['selfie_file'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? fullName;
  String? panNumber;
  String? aadharNumber;
  String? accountHolderName;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? branchName;
  String? kycStatus;
  String? panFileFront;
  String? panFileBack;
  String? aadharFrontFile;
  String? aadharBackFile;
  String? selfieFile;
  User? user;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['pan_number'] = panNumber;
    map['aadhar_number'] = aadharNumber;
    map['account_holder_name'] = accountHolderName;
    map['bank_name'] = bankName;
    map['account_number'] = accountNumber;
    map['ifsc_code'] = ifscCode;
    map['branch_name'] = branchName;
    map['kyc_status'] = kycStatus;
    map['pan_file_front'] = panFileFront;
    map['pan_file_back'] = panFileBack;
    map['aadhar_front_file'] = aadharFrontFile;
    map['aadhar_back_file'] = aadharBackFile;
    map['selfie_file'] = selfieFile;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phone,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}