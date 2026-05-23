import 'package:base_module/base_module.dart';

class IndividualPrifileDetailsResponse extends BaseModel{
  IndividualPrifileDetailsResponse({
      super.status,
      super.message,
      this.data,});

  IndividualPrifileDetailsResponse.fromJson(dynamic json) {
    data = json['data'] != null ? IndividalProfileData.fromJson(json['data']) : null;
  }
  IndividalProfileData? data;

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

class IndividalProfileData {
  IndividalProfileData({
      this.id, 
      this.userId, 
      this.fullName, 
      this.mobileNumber, 
      this.email, 
      this.alternateMobileNumber, 
      this.fatherName, 
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

  IndividalProfileData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    alternateMobileNumber = json['alternate_mobile_number'];
    fatherName = json['father_name'];
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
  String? mobileNumber;
  String? email;
  String? alternateMobileNumber;
  String? fatherName;
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
    map['mobile_number'] = mobileNumber;
    map['email'] = email;
    map['alternate_mobile_number'] = alternateMobileNumber;
    map['father_name'] = fatherName;
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