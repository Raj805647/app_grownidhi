class BaseModel {
  bool? success;
  String? message;

  BaseModel({this.success, this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}