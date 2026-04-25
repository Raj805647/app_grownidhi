import 'package:base_module/base_module.dart';

class CourseDetailsResponse extends BaseModel {
  CourseDetailsResponse({
      super.status,
      super.message,
      this.data,});

  CourseDetailsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CourseDetailsData.fromJson(v));
      });
    }
  }

  List<CourseDetailsData>? data;

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

class CourseDetailsData {
  CourseDetailsData({
      this.id, 
      this.title, 
      this.thumbnail, 
      this.rating, 
      this.lessons, 
      this.students, 
      this.instructorName, 
      this.instructorImage, 
      this.courseCategoryId, 
      this.courseCategory, 
      this.courseLevelId, 
      this.courseLevel, 
      this.courseLanguageId, 
      this.courseLanguage, 
      this.price, 
      this.discount, 
      this.finalPrice,});

  CourseDetailsData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    lessons = json['lessons'];
    students = json['students'];
    instructorName = json['instructor_name'];
    instructorImage = json['instructor_image'];
    courseCategoryId = json['course_category_id'];
    courseCategory = json['course_category'];
    courseLevelId = json['course_level_id'];
    courseLevel = json['course_level'];
    courseLanguageId = json['course_language_id'];
    courseLanguage = json['course_language'];
    price = json['price'];
    discount = json['discount'];
    finalPrice = json['final_price'];
  }
  int? id;
  String? title;
  String? thumbnail;
  int? rating;
  int? lessons;
  int? students;
  String? instructorName;
  String? instructorImage;
  int? courseCategoryId;
  String? courseCategory;
  int? courseLevelId;
  String? courseLevel;
  int? courseLanguageId;
  String? courseLanguage;
  int? price;
  int? discount;
  int? finalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['thumbnail'] = thumbnail;
    map['rating'] = rating;
    map['lessons'] = lessons;
    map['students'] = students;
    map['instructor_name'] = instructorName;
    map['instructor_image'] = instructorImage;
    map['course_category_id'] = courseCategoryId;
    map['course_category'] = courseCategory;
    map['course_level_id'] = courseLevelId;
    map['course_level'] = courseLevel;
    map['course_language_id'] = courseLanguageId;
    map['course_language'] = courseLanguage;
    map['price'] = price;
    map['discount'] = discount;
    map['final_price'] = finalPrice;
    return map;
  }

}