import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:base_module/core/models/agent_dashboard_response.dart';
import 'package:base_module/core/models/agent_client_response.dart';

class AgentDashboardProvider extends BaseProvider {
  bool isLoading = false;
  AgentDashboardData agentDashboardData = AgentDashboardData();
  List<AgentClientData> agentClientData = [];

  Future<void> fetchAgentDashboard() async {
    try {
      isLoading = true;

      final response = await authRepository.agentDashboard();
      print('adbfhbdsaf=> ${response.data}');

      isLoading = false;
      notifyListeners();
      if (response.isSuccess == true) {
        agentDashboardData = AgentDashboardData.fromJson(response.data['data']);
        fetchDashboardData();
        print('adfbdsakjbf=> $agentDashboardData');
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

  Future<void> fetchDashboardData() async {
    try {
      final response = await authRepository.agentClientData();
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        agentClientData = rawList
            .map((e) => AgentClientData.fromJson(e))
            .toList();
        ;
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

  void markNotificationAsRead(int index) {
  }
}