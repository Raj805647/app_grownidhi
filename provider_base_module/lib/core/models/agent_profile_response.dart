import 'package:base_module/base_module.dart';

class AgentProfileResponse extends BaseModel{
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
    this.experience,
    this.experienceDocument,
    this.education,
    this.educationDocument,
    this.annualIncome,
    this.monthlyIncome,
    this.companies,
    this.products,});

  AgentProfileData.fromJson(dynamic json) {
    id = json['id'];
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
    experience = json['experience'];
    experienceDocument = json['experience_document'];
    education = json['education'];
    educationDocument = json['education_document'];
    annualIncome = json['annual_income'];
    monthlyIncome = json['monthly_income'];
    companies = json['companies'] != null ? json['companies'].cast<String>() : [];
    products = json['products'] != null ? json['products'].cast<String>() : [];
  }
  int? id;
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
  String? experience;
  String? experienceDocument;
  String? education;
  String? educationDocument;
  String? annualIncome;
  String? monthlyIncome;
  List<String>? companies;
  List<String>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    map['experience'] = experience;
    map['experience_document'] = experienceDocument;
    map['education'] = education;
    map['education_document'] = educationDocument;
    map['annual_income'] = annualIncome;
    map['monthly_income'] = monthlyIncome;
    map['companies'] = companies;
    map['products'] = products;
    return map;
  }

}