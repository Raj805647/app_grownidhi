import 'package:app_grownidhi/features/screens/agent/agent_client_data/agent_client_data_provider.dart';
import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:base_module/core/models/agent_dashboard_response.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:base_module/core/models/client_application_response.dart';

class AgentDashboardProvider extends BaseProvider {
  bool isLoading = false;
  AgentDashboardData agentDashboardData = AgentDashboardData();
  AgentClientDataProvider agentClientDataProvider = AgentClientDataProvider();
  List<AgentClientData> agentClientData = [];
  List<ClientApplicationData> clientApplication = [];

  Future<void> fetchAgentDashboard() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.agentDashboard();
      fetchDashboardData();
      fetchClientData();
      agentClientDataProvider.fetchAgentClientData();
      print('adbfhbdsaf=> ${response.data}');

      if (response.isSuccess == true) {
        agentDashboardData = AgentDashboardData.fromJson(response.data['data']);
        // agentClientDataProvider.fetchAgentClientData();
        print('adfbdsakjbf=> $agentDashboardData');
      } else {
        print(response.data);
      }
    } catch (error) {
      print("Dashboard Error: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDashboardData() async {
    try {
      final response = await authRepository.agentClientData();
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        agentClientData = rawList
            .map((e) => AgentClientData.fromJson(e))
            .toList();
        notifyListeners();
        print('adfbdsakjbf=> $agentDashboardData');
      } else {
        print(response.data);
      }
    } catch (error) {
      print("Dashboard Error: $error");
    } finally {

    }
  }

  Future<void> fetchClientData() async {
    try {
      final response = await authRepository.agentClientApplication();
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        clientApplication = rawList
            .map((e) => ClientApplicationData.fromJson(e))
            .toList();
        ;
        notifyListeners();
        print('fsdzgdsfgdv=> $agentDashboardData');
      } else {
        print(response.data);
      }
    } catch (error) {
      print("Dashadfdsavboard Error: $error");
    } finally {

    }
  }

}