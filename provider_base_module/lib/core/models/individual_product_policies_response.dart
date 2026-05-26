import 'package:base_module/base_module.dart';

class IndividualProductPoliciesResponse extends BaseModel {
  IndividualProductPoliciesResponse({
      super.status,
      super.message,
      this.totalPolicies, 
      this.data,});

  IndividualProductPoliciesResponse.fromJson(dynamic json) {
    totalPolicies = json['total_policies'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductPoliciesData.fromJson(v));
      });
    }
  }
  int? totalPolicies;
  List<ProductPoliciesData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['total_policies'] = totalPolicies;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductPoliciesData {
  ProductPoliciesData({
      this.policyId, 
      this.productId, 
      this.productName, 
      this.serviceCategoryId, 
      this.categoryName, 
      this.companyId, 
      this.applicationId, 
      this.applicationNo, 
      this.status, 
      this.formData, 
      this.createdAt,});

  ProductPoliciesData.fromJson(dynamic json) {
    policyId = json['policy_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    serviceCategoryId = json['service_category_id'];
    categoryName = json['category_name'];
    companyId = json['company_id'];
    applicationId = json['application_id'];
    applicationNo = json['application_no'];
    status = json['status'];
    formData = json['form_data'] != null
        ? Map<String, dynamic>.from(json['form_data'])
        : {};
    createdAt = json['created_at'];
  }
  int? policyId;
  int? productId;
  String? productName;
  int? serviceCategoryId;
  String? categoryName;
  int? companyId;
  int? applicationId;
  String? applicationNo;
  String? status;
  Map<String, dynamic>? formData;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['policy_id'] = policyId;
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['service_category_id'] = serviceCategoryId;
    map['category_name'] = categoryName;
    map['company_id'] = companyId;
    map['application_id'] = applicationId;
    map['application_no'] = applicationNo;
    map['status'] = status;
    map['form_details'] = formData;
    map['created_at'] = createdAt;
    return map;
  }

}