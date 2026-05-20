import 'package:base_module/base_module.dart';

class AgentClientMemberDataResponse  extends BaseModel{
  AgentClientMemberDataResponse({
      super.status,
      super.message,
      this.data,});

  AgentClientMemberDataResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AgentClientMemberData.fromJson(v));
      });
    }
  }
  List<AgentClientMemberData>? data;

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

class AgentClientMemberData {
  AgentClientMemberData({
      this.clientName, 
      this.clientId, 
      this.familyMember,});

  AgentClientMemberData.fromJson(dynamic json) {
    clientName = json['client_name'];
    clientId = json['client_id'];
    familyMember = json['family_member'] != null ? FamilyMember.fromJson(json['family_member']) : null;
  }
  String? clientName;
  int? clientId;
  FamilyMember? familyMember;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_name'] = clientName;
    map['client_id'] = clientId;
    if (familyMember != null) {
      map['family_member'] = familyMember?.toJson();
    }
    return map;
  }

}

class FamilyMember {
  FamilyMember({
      this.id, 
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
      this.createdAt,});

  FamilyMember.fromJson(dynamic json) {
    id = json['id'];
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
    documents = json['documents'] != null ? json['documents'].cast<String>() : [];
    notes = json['notes'];
    createdAt = json['created_at'];
  }
  int? id;
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
  List<String>? documents;
  String? notes;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    map['documents'] = documents;
    map['notes'] = notes;
    map['created_at'] = createdAt;
    return map;
  }

}