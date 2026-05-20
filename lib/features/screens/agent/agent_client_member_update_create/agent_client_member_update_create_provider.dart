import 'dart:io';
import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class AgentClientMemberUpdateCreateProvider extends BaseProvider {
  final imagePicker = ImagePickerService();

  File? imageFile;

  /// CONTROLLERS
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final occupationController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();

  /// DROPDOWN VALUES
  String? relationship;
  String? gender;
  bool? isDependent;

  /// PICK IMAGE

  Future<void> pickImage(BuildContext context) async {
    await imagePicker.showImageSourceDialog(
      context: context,
      onImagePicked: (XFile? file) {
        if (file != null) {
          imageFile = File(file.path);
          notifyListeners();
        }
      },
    );
  }

  /// SUBMIT

  void submitData(BuildContext context, int clientUserId) async {
    try {
      final Map<String, dynamic> body = {
        "user_id": clientUserId,
        "name": nameController.text,
        "relationship": relationship,
        "dob": dobController.text,
        "gender": gender,
        "is_dependent": isDependent == true ? 1 : 0,
        "annual_income": annualIncomeController.text,
        "occupation": occupationController.text,
        "pan": panController.text,
        "aadhar_number": aadharController.text,
        "contact_number": contactController.text,
        "email": emailController.text,
        "notes": notesController.text,
        "documents[]": imageFile != null
            ? await MultipartFile.fromFile(
                imageFile!.path,
                filename: imageFile!.path.split('/').last,
              )
            : null,
      };

      print("REQUEST BODY => $body");
      final response = await authRepository.agentClientMemberUpdateCreateData(
        body,
      );

      if(response.isSuccess == true){
        clearData();
        back(context);
      }

      print("RESPONSE => ${response.data}");
    } catch (error) {
      print("ERROR => $error");
    }
  }

  void clearData() {
    imageFile = null;
    nameController.clear();
    dobController.clear();
    annualIncomeController.clear();
    occupationController.clear();
    panController.clear();
    aadharController.clear();
    contactController.clear();
    emailController.clear();
    notesController.clear();

    /// CLEAR DROPDOWNS
    relationship = null;
    gender = null;
    isDependent = null;
    notifyListeners();
  }
}
