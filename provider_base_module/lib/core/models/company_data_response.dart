import 'package:base_module/base_module.dart';

class CompanyDataResponse extends BaseModel{
  CompanyDataResponse({
      super.status,
      super.message,
      this.data,});

  CompanyDataResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CompanyData.fromJson(v));
      });
    }
  }
  List<CompanyData>? data;

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

class CompanyData {
  CompanyData({
      this.id, 
      this.companyName,});

  CompanyData.fromJson(dynamic json) {
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