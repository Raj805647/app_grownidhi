import 'package:base_module/base_module.dart';

class ProductListResponse extends BaseModel {
  ProductListResponse({
      super.status,
      super.message,
      this.data,});

  ProductListResponse.fromJson(dynamic json) {
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
      this.name,});

  ProductListData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}