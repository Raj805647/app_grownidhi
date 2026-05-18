import 'package:base_module/base_module.dart';

class CompanyListResponse extends BaseModel {
  CompanyListResponse({
      super.status,
      super.message,
      this.data,});

  CompanyListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CompanyListData.fromJson(v));
      });
    }
  }
  List<CompanyListData>? data;

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

class CompanyListData {
  CompanyListData({
      this.id, 
      this.companyName, 
      this.contactNumber, 
      this.companyDetail, 
      this.companyAddress, 
      this.status, 
      this.createdBy, 
      this.createdAt, 
      this.updatedAt,});

  CompanyListData.fromJson(dynamic json) {
    id = json['id'];
    companyName = json['company_name'];
    contactNumber = json['contact_number'];
    companyDetail = json['company_detail'];
    companyAddress = json['company_address'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? companyName;
  String? contactNumber;
  String? companyDetail;
  String? companyAddress;
  String? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_name'] = companyName;
    map['contact_number'] = contactNumber;
    map['company_detail'] = companyDetail;
    map['company_address'] = companyAddress;
    map['status'] = status;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}