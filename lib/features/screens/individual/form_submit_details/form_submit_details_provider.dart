import 'dart:io';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:dio/dio.dart';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/form_state_details_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class FormSubmitDetailsProvider extends BaseProvider{
  bool isLoading = false;
  String appBarName = '';
  List<Fields> formDataList = [];

  Map<String, dynamic> selectedRadio = {};
  Map<String, dynamic> selectedDropdown = {};
  Map<String, List<dynamic>> selectedCheckbox = {};
  Map<String, TextEditingController> controllers = {};
  final ImagePickerService imagePickerService =
  ImagePickerService();

  Map<String, XFile?> selectedImages = {};
  void setFormData(List<Fields> data) {
    formDataList = data;

    for (var field in formDataList) {
      controllers[field.fieldName ?? ''] = TextEditingController();
    }

    notifyListeners();
  }

  TextEditingController getController(String fieldName) {
    return controllers[fieldName]!;
  }

  void setRadioValue(String fieldName, dynamic value) {
    selectedRadio[fieldName] = value;
    notifyListeners();
  }

  void toggleCheckbox(String fieldName, dynamic value) {

    if (selectedCheckbox[fieldName] == null) {
      selectedCheckbox[fieldName] = [];
    }

    if (selectedCheckbox[fieldName]!.contains(value)) {
      selectedCheckbox[fieldName]!.remove(value);
    } else {
      selectedCheckbox[fieldName]!.add(value);
    }

    notifyListeners();
  }

  bool isChecked(String fieldName, dynamic value) {
    return selectedCheckbox[fieldName]?.contains(value) ?? false;
  }

  void setDropdownValue(String fieldName, dynamic value) {
    selectedDropdown[fieldName] = value;
    notifyListeners();
  }

  /// PICK IMAGE
  Future<void> pickImage({
    required BuildContext context,
    required String fieldName,
  }) async {

    await imagePickerService.showImageSourceDialog(
      context: context,
      onImagePicked: (image) {

        if (image != null) {

          selectedImages[fieldName] = image;

          notifyListeners();
        }
      },
    );
  }

  /// GET IMAGE
  XFile? getImage(String fieldName) {
    return selectedImages[fieldName];
  }

  /// REMOVE IMAGE
  void removeImage(String fieldName) {

    selectedImages[fieldName] = null;

    notifyListeners();
  }
  Future<void> getFormValues(BuildContext context, ServiceProductsData productDetails) async {
    try {
      Map<String, dynamic> formValues = {};

      print("========== FORM START ==========");

      for (var field in formDataList) {
        final fieldName = field.fieldName ?? '';
        final fieldType = field.fieldType ?? '';

        dynamic value;

        // Get value based on field type
        switch (fieldType) {

          case "radio":
            value = selectedRadio[fieldName];
            break;

          case "checkbox":
            value = selectedCheckbox[fieldName];
            break;

          case "select":
            value = selectedDropdown[fieldName];
            break;

          case "image":
            value = selectedImages[fieldName];
            break;

          default:
            value = controllers[fieldName]?.text.trim();
        }

        print("Field Name : $fieldName");
        print("Field Type : $fieldType");
        print("Field Value: $value");

        // Add values to request body
        switch (fieldType) {
          case "image":
            if (value != null && value is XFile) {

              final file = await MultipartFile.fromFile(
                value.path,
                filename: value.name,
              );

              formValues[fieldName] = value.path;

              print("Image Path => ${value.path}");
              print("Image Name => ${value.name}");
            }
            break;

          default:
            formValues[fieldName] = value;
        }

        print("-------------------------------");
      }

      print("========== FINAL BODY ==========");
      formValues.forEach((key, value) {
        print("$key : $value");
      });
      formValues["product_id"] = productDetails.id ?? 0;
      formValues["service_category_id"] = productDetails.serviceId ?? 0;
      formValues["service_subcategory_id"] = productDetails.serviceTypeId ?? 0;

      // Loader start
      isLoading = true;
      notifyListeners();

      print("========== API CALLING ==========");

      // API call
      try {

        final response =
        await authRepository.submitFormDetails(formValues);

        print("SUCCESS => ${response.isSuccess}");
        print("SUCCESS => ${response.data}");
        print("SUCCESS => ${response.error}");

      } on DioException catch (e) {

        print("STATUS CODE => ${e.response?.statusCode}");

        print("RESPONSE DATA => ${e.response?.data}");

        print("ERROR => ${e.message}");

      }

      // Loader stop
      isLoading = false;
      notifyListeners();

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Form submitted successfully"),
        ),
      );

    } catch (e, stackTrace) {
      isLoading = false;
      notifyListeners();

      print("========== ERROR ==========");
      print(e);
      print(stackTrace);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {

    for (var controller in controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> fetchFormStateDetails(int productId) async {
    final userToken = await StorageService.getUserToken() ?? '';
    print('adhjvfhvdsf=> $userToken');
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.formStateDetails(productId);
      print('akdjbfkjbdsakbf=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List rawList = response.data['data']['fields'] ?? [];
        appBarName = response.data['data']['product_name'];

        formDataList = rawList.map((e) => Fields.fromJson(e)).toList();

        /// CREATE CONTROLLERS
        for (var field in formDataList) {
          final fieldName = field.fieldName ?? '';

          if (!controllers.containsKey(fieldName)) {
            controllers[fieldName] = TextEditingController();
          }
        }

        notifyListeners();
      }
    } catch (error, stackTrace) {
      print("🔥 Error: $error");
      print("📍 StackTrace: $stackTrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}