import 'package:base_module/base_module.dart';
class ClientApplicationResponse extends BaseModel {
  ClientApplicationResponse({
    super.status,
    super.message,
    this.totalApplications,
    this.data,
  });

  ClientApplicationResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    totalApplications = json['total_applications'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ClientApplicationData.fromJson(v));
      });
    }
  }

  int? totalApplications;
  List<ClientApplicationData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['status'] = status;
    map['message'] = message;
    map['total_applications'] = totalApplications;

    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class ClientApplicationData {
  ClientApplicationData({
    this.applicationId,
    this.applicationNo,
    this.status,
    this.submittedDate,
    this.client,
    this.product,
    this.applicationData,
  });

  ClientApplicationData.fromJson(dynamic json) {
    applicationId = json['application_id'];
    applicationNo = json['application_no'];
    status = json['status'];
    submittedDate = json['submitted_date'];

    client =
    json['client'] != null ? Client.fromJson(json['client']) : null;

    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;

    /// Dynamic JSON Object
    applicationData = json['application_data'] != null
        ? Map<String, dynamic>.from(json['application_data'])
        : null;
  }

  int? applicationId;
  String? applicationNo;
  String? status;
  String? submittedDate;
  Client? client;
  Product? product;

  /// Dynamic Form Data
  Map<String, dynamic>? applicationData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['application_id'] = applicationId;
    map['application_no'] = applicationNo;
    map['status'] = status;
    map['submitted_date'] = submittedDate;

    if (client != null) {
      map['client'] = client?.toJson();
    }

    if (product != null) {
      map['product'] = product?.toJson();
    }

    /// Dynamic JSON
    map['application_data'] = applicationData;

    return map;
  }
}

class Product {
  Product({
    this.productId,
    this.productName,
    this.category,
    this.subcategory,
  });

  Product.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    category = json['category'];
    subcategory = json['subcategory'];
  }

  int? productId;
  String? productName;
  String? category;
  String? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['product_id'] = productId;
    map['product_name'] = productName;
    map['category'] = category;
    map['subcategory'] = subcategory;

    return map;
  }
}

class Client {
  Client({
    this.clientId,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
  });

  Client.fromJson(dynamic json) {
    clientId = json['client_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImage = json['profile_image'];
  }

  int? clientId;
  String? name;
  String? email;
  String? phone;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['client_id'] = clientId;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['profile_image'] = profileImage;

    return map;
  }
}