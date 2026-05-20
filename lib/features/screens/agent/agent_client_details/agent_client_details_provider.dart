import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_client_member_data_response.dart';
import 'package:flutter/cupertino.dart';

class AgentClientDetailsProvider extends BaseProvider {
  bool isLoading = false;
  List<AgentClientMemberData> agentClientMemberData = [];

  Future<void> fetchClientMemberData() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.agentClientMemberData();
      print('adskjbfbdsasdf');
      print(response.isSuccess);
      print(response.data);
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        agentClientMemberData = rawList
            .map((e) => AgentClientMemberData.fromJson(e))
            .toList();
        ;
        notifyListeners();
      } else {
        print(response.data);
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print("Dashboard Error: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteClientMember(int id) async {
    try {
      await authRepository.deleteClientMemberData(id);

      agentClientMemberData.removeWhere((e) => e.familyMember?.id == id);

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
