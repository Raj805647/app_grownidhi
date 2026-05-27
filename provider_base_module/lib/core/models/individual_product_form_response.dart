import 'package:base_module/base_module.dart';

class IndividualProductFormResponse extends BaseModel{
  IndividualProductFormResponse({
      super.status,
      super.message,
      this.data,});

  IndividualProductFormResponse.fromJson(dynamic json) {
    data = json['data'] != null ? IndividualProductData.fromJson(json['data']) : null;
  }
  IndividualProductData? data;

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

class IndividualProductData {
  IndividualProductData({
      this.product, 
      this.formFields,});

  IndividualProductData.fromJson(dynamic json) {
    product = json['product'] != null ? InidividualProduct.fromJson(json['product']) : null;
    if (json['form_fields'] != null) {
      formFields = [];
      json['form_fields'].forEach((v) {
        formFields?.add(IndividualFormFields.fromJson(v));
      });
    }
  }
  InidividualProduct? product;
  List<IndividualFormFields>? formFields;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    if (formFields != null) {
      map['form_fields'] = formFields?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class IndividualFormFields {
  IndividualFormFields({
      this.id, 
      this.label, 
      this.fieldName, 
      this.fieldType, 
      this.options, 
      this.isRequired, 
      this.remark,});

  IndividualFormFields.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];
    options = json['options'] != null
        ? List<dynamic>.from(json['options'])
        : [];
    isRequired = json['is_required'];
    remark = json['remark'];
  }
  int? id;
  String? label;
  String? fieldName;
  String? fieldType;
  List<dynamic>? options;
  String? isRequired;
  String? remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    map['field_name'] = fieldName;
    map['field_type'] = fieldType;
    map['options'] = options;
    map['is_required'] = isRequired;
    map['remark'] = remark;
    return map;
  }

}

class InidividualProduct {
  InidividualProduct({
      this.productId, 
      this.productName, 
      this.serviceCategoryId, 
      this.categoryName, 
      this.serviceSubcategoryId, 
      this.subcategoryName,});

  InidividualProduct.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    serviceCategoryId = json['service_category_id'];
    categoryName = json['category_name'];
    serviceSubcategoryId = json['service_subcategory_id'];
    subcategoryName = json['subcategory_name'];
  }
  int? productId;
  String? productName;
  int? serviceCategoryId;
  String? categoryName;
  int? serviceSubcategoryId;
  String? subcategoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['service_category_id'] = serviceCategoryId;
    map['category_name'] = categoryName;
    map['service_subcategory_id'] = serviceSubcategoryId;
    map['subcategory_name'] = subcategoryName;
    return map;
  }

}