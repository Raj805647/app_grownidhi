import 'package:base_module/base_module.dart';

class ProductServiceResponse extends BaseModel{
  ProductServiceResponse({
      super.status,
      super.message,
      this.data,});

  ProductServiceResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductListData.fromJson(v));
      });
    }
  }
  List<ProductListData>? data;

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

class ProductListData {
  ProductListData({
      this.id, 
      this.serviceId, 
      this.serviceTypeId, 
      this.name, 
      this.minAmount, 
      this.maxAmount, 
      this.interestRate, 
      this.tenure, 
      this.premium, 
      this.eligibility, 
      this.requiredDocuments, 
      this.description, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy, 
      this.companies,});

  ProductListData.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    serviceTypeId = json['service_type_id'];
    name = json['name'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    interestRate = json['interest_rate'];
    tenure = json['tenure'];
    premium = json['premium'];
    eligibility = json['eligibility'];
    requiredDocuments = json['required_documents'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['companies'] != null) {
      companies = [];
      json['companies'].forEach((v) {
        companies?.add(Companies.fromJson(v));
      });
    }
  }
  int? id;
  int? serviceId;
  int? serviceTypeId;
  String? name;
  String? minAmount;
  String? maxAmount;
  String? interestRate;
  String? tenure;
  String? premium;
  String? eligibility;
  String? requiredDocuments;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  List<Companies>? companies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['service_type_id'] = serviceTypeId;
    map['name'] = name;
    map['min_amount'] = minAmount;
    map['max_amount'] = maxAmount;
    map['interest_rate'] = interestRate;
    map['tenure'] = tenure;
    map['premium'] = premium;
    map['eligibility'] = eligibility;
    map['required_documents'] = requiredDocuments;
    map['description'] = description;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    if (companies != null) {
      map['companies'] = companies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Companies {
  Companies({
      this.id, 
      this.companyName,});

  Companies.fromJson(dynamic json) {
    id = json['id'];
    companyName = json['company_name'];
  }
  int? id;
  String? companyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['company_name'] = companyName;
    return map;
  }

}