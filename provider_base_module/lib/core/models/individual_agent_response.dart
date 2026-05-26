import 'package:base_module/base_module.dart';

class IndividualAgentResponse extends BaseModel{
  IndividualAgentResponse({
      super.status,
      super.message,
      this.totalAgents, 
      this.data,});

  IndividualAgentResponse.fromJson(dynamic json) {
    totalAgents = json['total_agents'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AgentData.fromJson(v));
      });
    }
  }
  int? totalAgents;
  List<AgentData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['total_agents'] = totalAgents;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class AgentData {
  AgentData({
      this.id, 
      this.name, 
      this.email, 
      this.phone,});

  AgentData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

}