import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';

class AgentKycProvider extends BaseProvider {
  final imagePickerService = ImagePickerService();

  File? panCardImage;

  /// Controllers
  final dobController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final fatherNameController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final accountHolderController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();
  String gender = "Female";

  Future<void> pickExperienceDocument(BuildContext context) async {
    await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (value) {
        if (value != null) {
          panCardImage = File(value.path);
          notifyListeners();
        }
      },
    );
  }

  void submitKycUpdate(){
    final response = authRepository.agentProfile();
  }
}
