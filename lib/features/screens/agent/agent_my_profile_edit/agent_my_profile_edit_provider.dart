import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_profile_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';

class AgentMyProfileEditProvider extends BaseProvider {
  bool isLoading = false;
  AgentProfileData agentProfileData = AgentProfileData();

  final imagePickerService = ImagePickerService();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController alternateMobileNumberController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController annualIncomeController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();

  File? experienceDocument;
  File? educationDocument;

  Future<void> pickExperienceDocument(BuildContext context) async {
    final file = await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (value) {
        if (value != null) {
          experienceDocument = File(value.path);
          notifyListeners();
        }
      },
    );
  }

  Future<void> pickEducationDocument(BuildContext context) async {
    final file = await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (value) {
        if (value != null) {
          educationDocument = File(value.path);
          notifyListeners();
        }
      },
    );
  }

  Future<void> updateCreateProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final Map<String, dynamic> data = {
        "full_name": fullNameController.text.trim(),
        "father_name": fatherNameController.text.trim(),
        "mobile_number": mobileNumberController.text.trim(),
        "alternate_mobile_number": alternateMobileNumberController.text.trim(),
        "email": emailController.text.trim(),
        "dob": dobController.text.trim(),
        "gender": genderController.text.trim(),
        "marital_status": maritalStatusController.text.trim(),
        "address_line1": addressLine1Controller.text.trim(),
        "address_line2": addressLine2Controller.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "country": countryController.text.trim(),

        "experience_document": educationDocument?.path,
        "education_document": educationDocument?.path,

        "occupation": occupationController.text.trim(),
        "designation": designationController.text.trim(),
        "experience": experienceController.text.trim(),
        "education": educationController.text.trim(),

        "annual_income": annualIncomeController.text.trim(),
        "monthly_income": monthlyIncomeController.text.trim(),

        'company_ids[]': [],
        'product_ids[]': [],
      };

      final response = await authRepository.agentUpdateProfile(data);

      if (response.isSuccess == true) {

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
