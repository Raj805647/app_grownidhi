import 'package:base_module/base_module.dart';

class IndividualDashboardResponse extends BaseModel {
  IndividualDashboardResponse({
      super.status,
      super.message,
      this.data,});

  IndividualDashboardResponse.fromJson(dynamic json) {
    data = json['data'] != null ? IndividualDashboardData.fromJson(json['data']) : null;
  }
  IndividualDashboardData? data;

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

class IndividualDashboardData {
  IndividualDashboardData({
      this.totalMembers, 
      this.totalPolicies, 
      this.activePolicies, 
      this.pendingPolicies, 
      this.approvedKyc, 
      this.pendingKyc, 
      this.totalCategories,});

  IndividualDashboardData.fromJson(dynamic json) {
    totalMembers = json['total_members'];
    totalPolicies = json['total_policies'];
    activePolicies = json['active_policies'];
    pendingPolicies = json['pending_policies'];
    approvedKyc = json['approved_kyc'];
    pendingKyc = json['pending_kyc'];
    totalCategories = json['total_categories'];
  }
  int? totalMembers;
  int? totalPolicies;
  int? activePolicies;
  int? pendingPolicies;
  int? approvedKyc;
  int? pendingKyc;
  int? totalCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_members'] = totalMembers;
    map['total_policies'] = totalPolicies;
    map['active_policies'] = activePolicies;
    map['pending_policies'] = pendingPolicies;
    map['approved_kyc'] = approvedKyc;
    map['pending_kyc'] = pendingKyc;
    map['total_categories'] = totalCategories;
    return map;
  }

}