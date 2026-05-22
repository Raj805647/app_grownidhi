import 'package:base_module/base_module.dart';

class ClientCompleteProfileResponse extends BaseModel {
  ClientCompleteProfileResponse({
      super.status,
    super.message,
      this.data,});

  ClientCompleteProfileResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ClientCompleteData.fromJson(v));
      });
    }
  }
  List<ClientCompleteData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ClientCompleteData {
  ClientCompleteData({
      this.id, 
      this.userId, 
      this.fullName, 
      this.fatherName, 
      this.mobileNumber, 
      this.alternateMobileNumber, 
      this.email, 
      this.dob, 
      this.gender, 
      this.maritalStatus, 
      this.addressLine1, 
      this.addressLine2, 
      this.city, 
      this.state, 
      this.pincode, 
      this.country, 
      this.occupation, 
      this.designation, 
      this.education, 
      this.annualIncome, 
      this.monthlyIncome, 
      this.educationDocument, 
      this.createdAt,});

  ClientCompleteData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    fatherName = json['father_name'];
    mobileNumber = json['mobile_number'];
    alternateMobileNumber = json['alternate_mobile_number'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
    occupation = json['occupation'];
    designation = json['designation'];
    education = json['education'];
    annualIncome = json['annual_income'];
    monthlyIncome = json['monthly_income'];
    educationDocument = json['education_document'];
    createdAt = json['created_at'];
  }
  int? id;
  int? userId;
  String? fullName;
  String? fatherName;
  String? mobileNumber;
  String? alternateMobileNumber;
  String? email;
  String? dob;
  String? gender;
  String? maritalStatus;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? pincode;
  String? country;
  String? occupation;
  String? designation;
  String? education;
  String? annualIncome;
  String? monthlyIncome;
  String? educationDocument;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['father_name'] = fatherName;
    map['mobile_number'] = mobileNumber;
    map['alternate_mobile_number'] = alternateMobileNumber;
    map['email'] = email;
    map['dob'] = dob;
    map['gender'] = gender;
    map['marital_status'] = maritalStatus;
    map['address_line1'] = addressLine1;
    map['address_line2'] = addressLine2;
    map['city'] = city;
    map['state'] = state;
    map['pincode'] = pincode;
    map['country'] = country;
    map['occupation'] = occupation;
    map['designation'] = designation;
    map['education'] = education;
    map['annual_income'] = annualIncome;
    map['monthly_income'] = monthlyIncome;
    map['education_document'] = educationDocument;
    map['created_at'] = createdAt;
    return map;
  }

}