import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';


class AgentKycProvider extends BaseProvider {
  UserData userData = UserData();
  final imagePickerService = ImagePickerService();
  bool isLoading = false;

  Map<String, File?> documentImages = {
    "panFront": null,
    "panBack": null,
    "profile": null,
    "aadharFront": null,
    "aadharBack": null,
  };

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
  String gender = "Select Gender";

  Future<void> pickImage({
    required BuildContext context,
    required String keyName,
  }) async {

    await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (XFile? pickedFile) {
        documentImages[keyName] = File(pickedFile!.path);

        notifyListeners();
      },
    );
  }
  /// Remove Image
  void removeImage(String keyName) {
    documentImages[keyName] = null;
    notifyListeners();
  }

  /// Get Image
  File? getImage(String keyName) {
    return documentImages[keyName];
  }

  Future<MultipartFile?> getMultipartFile(File? file) async {
    if (file == null) return null;

    return await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
  }

  Future<void> submitKycUpdate(BuildContext context) async {
    try {

      /// Loading Start
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> requestBody = {
        "dob": dobController.text.trim(),
        "gender": gender,
        "pan_number": panController.text.trim(),
        "aadhar_number": aadharController.text.trim(),
        "father_name": fatherNameController.text.trim(),
        "address_line1": address1Controller.text.trim(),
        "address_line2": address2Controller.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "country": countryController.text.trim(),
        "account_holder_name":
        accountHolderController.text.trim(),
        "bank_name": bankNameController.text.trim(),
        "account_number": accountNumberController.text.trim(),
        "ifsc_code": ifscController.text.trim(),
        "branch_name": branchController.text.trim(),

        "pan_file_front":
        await getMultipartFile(documentImages['panFront']),

        "pan_file_back":
        await getMultipartFile(documentImages['panBack']),

        "aadhar_front_file":
        await getMultipartFile(documentImages['aadharFront']),

        "aadhar_back_file":
        await getMultipartFile(documentImages['aadharBack']),

        "selfie_file":
        await getMultipartFile(documentImages['profile']),
      };

      /// Request Log
      debugPrint("KYC Request Body:");
      debugPrint(requestBody.toString());

      /// API Call
      final response =
      await authRepository.kycUpdateStore(requestBody);

      /// Response Log
      debugPrint("KYC Response:");
      debugPrint(response.toString());

      if (response.isSuccess == true) {
        debugPrint("KYC Submitted Successfully");
        clearKycForm();
        back(context);
      }

    } catch (e, stackTrace) {

      /// Error Log
      debugPrint("KYC Submit Error: $e");
      debugPrint(stackTrace.toString());
    } finally {

      /// Loading Stop
      isLoading = false;
      notifyListeners();
    }
  }
  void clearKycForm() {
    dobController.clear();
    panController.clear();
    aadharController.clear();
    fatherNameController.clear();
    address1Controller.clear();
    address2Controller.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    countryController.clear();
    accountHolderController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    ifscController.clear();
    branchController.clear();

    /// Reset Gender
    gender = "Select Gender";

    /// Clear Images
    documentImages.updateAll((key, value) => null);

    notifyListeners();
  }
}
