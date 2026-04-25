import 'package:base_module/base_module.dart';

class FilterCourseResponse extends BaseModel {
  FilterCourseResponse({
      super.status, 
      super.message, 
      this.data,});

  FilterCourseResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FilterCourseData.fromJson(v));
      });
    }
  }
  
  List<FilterCourseData>? data;

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

class FilterCourseData {
  FilterCourseData({
      this.id, 
      this.name,});

  FilterCourseData.fromJson(dynamic json) {
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