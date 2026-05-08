import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class KycUpdateProvider extends BaseProvider {
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
  bool isLoading = false;
  String? gender;


  final Map<String, String?> _images = {};

  /// Get image
  String? getImagePath(String type) {
    return _images[type];
  }

  /// Set image
  void setImage(String type, String path) {
    _images[type] = path;
    notifyListeners();
  }

  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }


  /// Remove image
  void removeImage(String type) {
    _images[type] = null; // or use remove(type)
    notifyListeners();
  }




  Future<void> submitKyc() async {
    notifyListeners();

    // 🔥 API call here

    await Future.delayed(const Duration(seconds: 2));

    notifyListeners();
  }
}