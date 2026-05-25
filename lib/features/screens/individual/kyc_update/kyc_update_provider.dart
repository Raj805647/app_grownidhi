import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:base_module/core/models/individual_kyc_data_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class KycUpdateProvider extends BaseProvider {
  final imagePickerService = ImagePickerService();
  IndividualKYCData individualKYCData = IndividualKYCData();
  bool isSubmitLoad = false;
  bool isLoad = false;

  Map<String, File?> documentImages = {
    "panFront": null,
    "panBack": null,
    "profile": null,
    "aadharFront": null,
    "aadharBack": null,
  };
  Map<String, String?> documentImageUrls = {
    "panFront": null,
    "panBack": null,
    "profile": null,
    "aadharFront": null,
    "aadharBack": null,
  };

  /// Controllers
  final panController = TextEditingController();
  final aadharController = TextEditingController();
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

  Future<void> fetchKYCData() async {
    try {
      isLoad = true;
      notifyListeners();

      final response = await authRepository.getIndividualKYC();
      if (response.isSuccess == true) {
        individualKYCData = IndividualKYCData.fromJson(response.data['data']);
        notifyListeners();

        initializeKycData();
      }
    } catch (error) {
      print('adskfbkjdsafkdsa=> $error');
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

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
    try {
      if (file == null) return null;

      final exists = await file.exists();

      if (!exists) {
        debugPrint("File does not exist: ${file.path}");
        return null;
      }

      return await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );
    } catch (e) {
      debugPrint("Multipart Error: $e");
      return null;
    }
  }

  void initializeKycData() {
    panController.text =
        individualKYCData.panNumber ?? '';

    aadharController.text =
        individualKYCData.aadharNumber ?? '';

    address1Controller.text =  '';

    address2Controller.text = '';

    cityController.text = '';

    stateController.text = '';

    pincodeController.text = '';

    countryController.text =  '';

    accountHolderController.text =
        individualKYCData.accountHolderName ?? '';

    bankNameController.text =
        individualKYCData.bankName ?? '';

    accountNumberController.text =
        individualKYCData.accountNumber ?? '';

    ifscController.text =
        individualKYCData.ifscCode ?? '';

    branchController.text =
        individualKYCData.branchName ?? '';

    /// Reset Images
    documentImageUrls = {
      "panFront": individualKYCData.panFileFront,
      "panBack": individualKYCData.panFileBack,
      "profile": individualKYCData.selfieFile,
      "aadharFront": individualKYCData.aadharFrontFile,
      "aadharBack": individualKYCData.aadharBackFile,
    };

    notifyListeners();
  }

  Future<void> submitKycUpdate(BuildContext context) async {
    try {
      isSubmitLoad = true;
      notifyListeners();

      Map<String, dynamic> requestBody = {
        "aadhar_number": aadharController.text.trim(),
        "address_line1": address1Controller.text.trim(),
        "address_line2": address2Controller.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "country": countryController.text.trim(),
        "account_holder_name": accountHolderController.text.trim(),
        "bank_name": bankNameController.text.trim(),
        "account_number": accountNumberController.text.trim(),
        "ifsc_code": ifscController.text.trim(),
        "branch_name": branchController.text.trim(),

        "pan_file_front": await getMultipartFile(documentImages['panFront']),

        "pan_file_back": await getMultipartFile(documentImages['panBack']),

        "aadhar_front_file": await getMultipartFile(
          documentImages['aadharFront'],
        ),

        "aadhar_back_file": await getMultipartFile(
          documentImages['aadharBack'],
        ),

        "selfie_file": await getMultipartFile(documentImages['profile']),
      };

      /// Request Log
      debugPrint("KYC Request Body:");
      debugPrint(requestBody.toString());

      /// API Call
      final response = await authRepository.individualAddUpdateKYC(requestBody);

      /// Response Log
      debugPrint("KYC Response:");
      debugPrint(response.toString());

      if (response.isSuccess == true) {
        debugPrint("KYC Submitted Successfully");
        back(context);
        clearKycForm();
      }else{
        back(context);
        clearKycForm();

      }
    } catch (e, stackTrace) {
      /// Error Log
      debugPrint("KYC Submit Error: $e");
      debugPrint(stackTrace.toString());
    } finally {
      /// Loading Stop
      isSubmitLoad = false;
      notifyListeners();
    }
  }

  void clearKycForm() {
    panController.clear();
    aadharController.clear();
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

    /// Clear Images
    documentImages.updateAll((key, value) => null);

    notifyListeners();
  }
}
