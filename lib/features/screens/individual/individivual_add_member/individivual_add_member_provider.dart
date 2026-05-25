import 'dart:io';
import 'dart:math';

import 'package:base_module/base_module.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class IndividualAddMemberProvider extends BaseProvider {
  final ImagePickerService imagePickerService =
  ImagePickerService();

  bool isLoad = false;

  /// Document Image
  File? documentImage;

  /// Controllers
  final nameController = TextEditingController();
  final relationshipController = TextEditingController();
  final dobController = TextEditingController();
  final annualIncomeController = TextEditingController();
  final occupationController = TextEditingController();
  final panController = TextEditingController();
  final aadharController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();

  /// Dropdown Values
  String gender = "Male";
  bool isDependent = true;

  /// Pick Image
  Future<void> pickImage({
    required BuildContext context,
  }) async {
    await imagePickerService.showImageSourceDialog(
      context: context,

      onImagePicked: (XFile? pickedFile) {
        if (pickedFile == null) return;

        documentImage = File(pickedFile.path);

        notifyListeners();
      },
    );
  }

  /// Remove Image
  void removeImage() {
    documentImage = null;
    notifyListeners();
  }

  /// Get Multipart File
  Future<MultipartFile?> getMultipartFile(
      File? file,
      ) async {
    try {
      if (file == null) return null;

      final exists = await file.exists();

      if (!exists) {
        debugPrint(
          "File does not exist: ${file.path}",
        );
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

  /// Add / Update Member
  Future<void> addUpdateMembers() async {
    try {
      isLoad = true;
      notifyListeners();

      Map<String, dynamic> body = {
        'name': nameController.text.trim(),

        'relationship':
        relationshipController.text.trim(),

        'dob': dobController.text.trim(),

        'gender': gender,

        'is_dependent': isDependent ? 1 : 0,

        'annual_income':
        annualIncomeController.text.trim(),

        'occupation':
        occupationController.text.trim(),

        'pan': panController.text.trim(),

        'aadhar_number':
        aadharController.text.trim(),

        'contact_number':
        contactNumberController.text.trim(),

        'email': emailController.text.trim(),

        'notes': notesController.text.trim(),

        'documents[]':
        await getMultipartFile(documentImage),
      };

      debugPrint("Request Body => $body");

      final response =
      await authRepository.individualUpdateMembers(
        body,
      );

      debugPrint("Response => ${response.data}");

      if (response.isSuccess == true) {
        clearForm();
      }
    } catch (error) {
      debugPrint(
        'Add Member Error => $error',
      );
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

  /// Clear Form
  void clearForm() {
    nameController.clear();
    relationshipController.clear();
    dobController.clear();
    annualIncomeController.clear();
    occupationController.clear();
    panController.clear();
    aadharController.clear();
    contactNumberController.clear();
    emailController.clear();
    notesController.clear();

    gender = "Male";
    isDependent = true;

    documentImage = null;

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    relationshipController.dispose();
    dobController.dispose();
    annualIncomeController.dispose();
    occupationController.dispose();
    panController.dispose();
    aadharController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    notesController.dispose();

    super.dispose();
  }
}