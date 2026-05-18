import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:base_module/core/models/agent_profile_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';

class AgentMyProfileProvider extends BaseProvider {
  bool isLoading = false;
  AgentProfileData agentProfileData = AgentProfileData();

  Future<void> fetchAgentMyProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.agentProfile();

      if (response.isSuccess == true) {
        agentProfileData = AgentProfileData.fromJson(response.data['data']);
        notifyListeners();
      } else {
        print(response.data);
      }
    } catch (e) {
      print("Profile Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
