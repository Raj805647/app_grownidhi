import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
class KycUpdateProvider extends BaseProvider {

  bool isLoading = false;

  /// FILES
  String? panFront, panBack, aadhaarFront, aadhaarBack, selfie;

  /// CONTROLLERS
  final dobController = TextEditingController();
  final panController = TextEditingController();
  final aadhaarController = TextEditingController();
  final fatherController = TextEditingController();

  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();

  final accountNameController = TextEditingController();
  final bankController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();

  String? gender;

  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }

  /// FILE PICKER (mock)
  void pickFile(String type) {
    // integrate file_picker here
    switch (type) {
      case "pan_front":
        panFront = "file_selected.pdf";
        break;
      case "pan_back":
        panBack = "file_selected.pdf";
        break;
      case "aadhaar_front":
        aadhaarFront = "file_selected.pdf";
        break;
      case "aadhaar_back":
        aadhaarBack = "file_selected.pdf";
        break;
      case "selfie":
        selfie = "image.png";
        break;
    }
    notifyListeners();
  }

  Future<void> submitKyc() async {
    isLoading = true;
    notifyListeners();

    // 🔥 API call here

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();
  }
}