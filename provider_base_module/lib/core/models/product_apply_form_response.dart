import 'package:base_module/base_module.dart';

class ProductApplyFormResponse extends BaseModel {
  ProductApplyFormResponse({
      super.status,
      super.message,
      this.data,});

  ProductApplyFormResponse.fromJson(dynamic json) {
    data = json['data'] != null ? ProductApplyFormData.fromJson(json['data']) : null;
  }

  ProductApplyFormData? data;

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

class ProductApplyFormData {
  ProductApplyFormData({
      this.product, 
      this.formFields,});

  ProductApplyFormData.fromJson(dynamic json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['form_fields'] != null) {
      formFields = [];
      json['form_fields'].forEach((v) {
        formFields?.add(FormFields.fromJson(v));
      });
    }
  }
  Product? product;
  List<FormFields>? formFields;

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

class FormFields {
  FormFields({
    this.id,
    this.label,
    this.fieldName,
    this.fieldType,
    this.options,
    this.isRequired,
    this.remark,
  });

  FormFields.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'];
    fieldName = json['field_name'];
    fieldType = json['field_type'];

    /// FIXED
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

    /// FIXED
    map['options'] = options;

    map['is_required'] = isRequired;
    map['remark'] = remark;

    return map;
  }
}

class Product {
  Product({
      this.productId, 
      this.productName, 
      this.categoryName, 
      this.subcategoryName, 
      this.serviceCategoryId, 
      this.serviceSubcategoryId,});

  Product.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    serviceCategoryId = json['service_category_id'];
    serviceSubcategoryId = json['service_subcategory_id'];
  }
  int? productId;
  String? productName;
  String? categoryName;
  String? subcategoryName;
  int? serviceCategoryId;
  int? serviceSubcategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['category_name'] = categoryName;
    map['subcategory_name'] = subcategoryName;
    map['service_category_id'] = serviceCategoryId;
    map['service_subcategory_id'] = serviceSubcategoryId;
    return map;
  }

}