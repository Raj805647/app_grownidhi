import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:base_module/core/models/agent_client_member_data_response.dart';

class AgentClientDataProvider extends BaseProvider {
  bool isLoading = false;

  List<AgentClientData> agentClientData = [];

  Future<void> fetchAgentClientData() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.agentClientData();
      print('adskjbfbdsasdf');
      print(response.isSuccess);
      print(response.data);
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        agentClientData = rawList
            .map((e) => AgentClientData.fromJson(e))
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
}
