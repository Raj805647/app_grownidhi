import 'package:base_module/base_module.dart';

class AgentDashboardResponse  extends BaseModel{
  AgentDashboardResponse({
      super.status,
      super.message,
      this.data,});

  AgentDashboardResponse.fromJson(dynamic json) {
    data = json['data'] != null ? AgentDashboardData.fromJson(json['data']) : null;
  }
  AgentDashboardData? data;

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

class AgentDashboardData {
  AgentDashboardData({
      this.totalClients, 
      this.totalCommission, 
      this.totalPolicies, 
      this.totalEarning,});

  AgentDashboardData.fromJson(dynamic json) {
    totalClients = json['total_clients'];
    totalCommission = json['total_commission'];
    totalPolicies = json['total_policies'];
    totalEarning = json['total_earning'];
  }
  int? totalClients;
  int? totalCommission;
  int? totalPolicies;
  int? totalEarning;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_clients'] = totalClients;
    map['total_commission'] = totalCommission;
    map['total_policies'] = totalPolicies;
    map['total_earning'] = totalEarning;
    return map;
  }

}