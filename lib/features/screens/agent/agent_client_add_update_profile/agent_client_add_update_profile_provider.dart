import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/client_complete_profile_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class AgentClientAddUpdateProfileProvider extends BaseProvider {
  bool isLoading = false;
  final imagePicker = ImagePickerService();

  final fatherNameController = TextEditingController();
  final alternateMobileController = TextEditingController();
  final dobController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final countryController = TextEditingController();
  final occupationController = TextEditingController();
  final designationController = TextEditingController();
  final educationController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final monthlyIncomeController = TextEditingController();

  String? gender;
  String? maritalStatus;
  String? educationDocumentName;

  File? educationDocument;

  Future<void> pickEducationDocument(BuildContext context) async {

    await imagePicker.showImageSourceDialog(
      context: context,
      onImagePicked: (XFile? file) {

        if (file != null) {

          educationDocument = File(file.path);

          // Set filename
          educationDocumentName = file.name;

          notifyListeners();
        }
      },
    );
  }

  void initailizeTextController(ClientCompleteData clientData) {
    fatherNameController.text = clientData.fatherName ?? '';
    alternateMobileController.text = clientData.alternateMobileNumber ?? '';
    dobController.text = clientData.dob ?? '';
    addressLine1Controller.text = clientData.addressLine1 ?? '';
    addressLine2Controller.text = clientData.addressLine2 ?? '';
    cityController.text = clientData.city ?? '';
    stateController.text = clientData.state ?? '';
    pincodeController.text = clientData.pincode ?? '';
    countryController.text = clientData.country ?? '';
    occupationController.text = clientData.occupation ?? '';
    designationController.text = clientData.designation ?? '';
    educationController.text = clientData.education ?? '';
    annualIncomeController.text = clientData.annualIncome ?? '';
    monthlyIncomeController.text = clientData.monthlyIncome ?? '';
    gender = clientData.gender;
    maritalStatus = clientData.maritalStatus;
    educationDocumentName = clientData.educationDocument;
    notifyListeners();
  }

  Future<void> submitClientDta(BuildContext context, int clientId) async {
    print('akdsfdsavf=> ${educationDocument?.path}');
    try {
      isLoading = true;
      notifyListeners();

      final Map<String, dynamic> body = {
        'user_id': clientId,
        "father_name": fatherNameController.text.trim(),
        "alternate_mobile_number": alternateMobileController.text.trim(),
        "dob": dobController.text.trim(),
        "gender": gender,
        "marital_status": maritalStatus,
        "address_line1": addressLine1Controller.text.trim(),
        "address_line2": addressLine2Controller.text.trim(),
        "city": cityController.text.trim(),
        "state": stateController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "country": countryController.text.trim(),
        "occupation": occupationController.text.trim(),
        "designation": designationController.text.trim(),
        "education": educationController.text.trim(),
        "annual_income": annualIncomeController.text.trim(),
        "monthly_income": monthlyIncomeController.text.trim(),
        if (educationDocument != null)
          "education_document": await MultipartFile.fromFile(
            educationDocument!.path,
            filename: educationDocument!.path.split('/').last,
          ),
      };

      final response = await authRepository.agentClientAddUpdateProfile(body);
      print('Response Data => ${response.data}');
      print('Response Success => ${response.isSuccess}');
      print('Response Error => ${response.error}');

      if (response.isSuccess == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Client profile submitted successfully"),
            backgroundColor: Colors.green,
          ),
        );

        clearAll();

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error?.toString() ?? "Something went wrong"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Submit Error => $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearAll() {
    fatherNameController.clear();
    alternateMobileController.clear();
    dobController.clear();
    addressLine1Controller.clear();
    addressLine2Controller.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    countryController.clear();
    occupationController.clear();
    designationController.clear();
    educationController.clear();
    annualIncomeController.clear();
    monthlyIncomeController.clear();
    gender = null;
    maritalStatus = null;
    educationDocument = null;
    educationDocumentName = null;

    notifyListeners();
  }
}
