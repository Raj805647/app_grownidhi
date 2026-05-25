import 'package:base_module/base_module.dart';

class IndividualMembersResponse extends BaseModel {
  IndividualMembersResponse({
    super.status,
    super.message,
    this.totalFamilyMembers,
    this.data,
  });

  IndividualMembersResponse.fromJson(dynamic json) {
    totalFamilyMembers = json['total_family_members'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(IndividualMembersData.fromJson(v));
      });
    }
  }

  int? totalFamilyMembers;
  List<IndividualMembersData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['total_family_members'] = totalFamilyMembers;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class IndividualMembersData {
  IndividualMembersData({
    this.id,
    this.userId,
    this.name,
    this.relationship,
    this.dob,
    this.gender,
    this.isDependent,
    this.annualIncome,
    this.occupation,
    this.pan,
    this.aadharNumber,
    this.contactNumber,
    this.email,
    this.documents,
    this.notes,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  IndividualMembersData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    relationship = json['relationship'];
    dob = json['dob'];
    gender = json['gender'];
    isDependent = json['is_dependent'];
    annualIncome = json['annual_income'];
    occupation = json['occupation'];
    pan = json['pan'];
    aadharNumber = json['aadhar_number'];
    contactNumber = json['contact_number'];
    email = json['email'];
    if (json['documents'] != null) {
      documents = List<String>.from(
        json['documents'],
      );
    }
    notes = json['notes'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? name;
  String? relationship;
  String? dob;
  String? gender;
  bool? isDependent;
  String? annualIncome;
  String? occupation;
  String? pan;
  String? aadharNumber;
  String? contactNumber;
  String? email;
  List? documents;
  String? notes;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['relationship'] = relationship;
    map['dob'] = dob;
    map['gender'] = gender;
    map['is_dependent'] = isDependent;
    map['annual_income'] = annualIncome;
    map['occupation'] = occupation;
    map['pan'] = pan;
    map['aadhar_number'] = aadharNumber;
    map['contact_number'] = contactNumber;
    map['email'] = email;
    if (documents != null) {
      map['documents'] = documents?.map((v) => v.toJson()).toList();
    }
    map['notes'] = notes;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
