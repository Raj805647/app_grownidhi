import 'dart:io';

import 'package:base_module/core/models/agent_client_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AgentAddClientDataProvider extends BaseProvider{
  final imagePickerService = ImagePickerService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Status
  int status = 1;
  bool isLoading = false;

  File? profileImage;

  void autoField(AgentClientData agentClientData){
    // profileImage = agentClientData.profileImage
    nameController.text = agentClientData.name ?? '';
    emailController.text = agentClientData.email ?? '';
    phoneController.text = agentClientData.phone ?? '';

  }

  Future<void> pickProfileImage({required BuildContext context}) async {
    final file = await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (value) {
        if (value != null) {
          profileImage = File(value.path);
          notifyListeners();
        }
      },
    );
  }

  void removeProfileImage() {
    profileImage = null;
    notifyListeners();
  }

  void changeStatus(int? value) {
    status = value ?? 1;
    notifyListeners();
  }

  Future<void> agentAddClientData(BuildContext context, int? companyId) async {
    try {
      isLoading = true;
      notifyListeners();

      final Map<String, dynamic> data = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'status': status,
        'password': passwordController.text.trim(),
        'password_confirmation': confirmPasswordController.text.trim(),
          'profile_image': profileImage != null
              ? await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          )
              : null,
      };

      debugPrint(data.toString());

      final response = await authRepository.addClientMember(
        companyId ?? 0,
        data,
      );

      debugPrint("===== ADD CLIENT RESPONSE =====");
      debugPrint(response.toString());

      if (response.isSuccess == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
        clearForm();
        back(context);
      } else {
        debugPrint("Add Client Failed => ${response.data}");
      }
    } catch (e, stackTrace) {
      debugPrint("===== ADD CLIENT ERROR =====");
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    status = 1;
    profileImage = null;
    notifyListeners();
  }

}