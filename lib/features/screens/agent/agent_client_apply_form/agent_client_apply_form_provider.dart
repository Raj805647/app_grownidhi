import 'dart:io';

import 'package:app_grownidhi/features/screens/agent/agent_client_data/agent_client_data_provider.dart';
import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:base_module/core/models/product_apply_form_response.dart';
import 'package:base_module/core/models/company_data_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AgentClientApplyFormProvider extends BaseProvider {
  final imagePicker = ImagePickerService();
  bool isLoading = false;
  bool isSubmitLoading = false;

  ProductApplyFormData productApplyForm = ProductApplyFormData();

  AgentClientDataProvider clientData = AgentClientDataProvider();


  List<CompanyData> companyData = [];

  /// ================= PROVIDER =================

  List<int> selectedCompanyIds = [];
  List<int> selectedClientIds = [];

  List<String> selectedCompanyNames = [];
  List<String> selectedClientNames = [];

  Map<String, TextEditingController> controller = {};
  Map<String, dynamic> selectedRadio = {};
  Map<String, List<dynamic>> selectedCheckbox = {};
  Map<String, File?> selectedImages = {};
  Map<String, String> selectedDropdown = {};

  void setDropdownValue(String key, String value) {
    selectedDropdown[key] = value;
    notifyListeners();
  }

  void setRadioValue(String key, dynamic value) {
    selectedRadio[key] = value;
    notifyListeners();
  }

  bool isChecked(String key, dynamic value) {
    return selectedCheckbox[key]?.contains(value) ?? false;
  }

  void toggleCheckbox(String key, dynamic value) {
    selectedCheckbox.putIfAbsent(key, () => []);
    if (selectedCheckbox[key]!.contains(value)) {
      selectedCheckbox[key]!.remove(value);
    } else {
      selectedCheckbox[key]!.add(value);
    }

    notifyListeners();
  }

  void setImage(String key, File? file) {
    selectedImages[key] = file;
    notifyListeners();
  }

  Future<void> fetchApplyForm(int productId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.getAgentProductApplyForm(productId);
      if (response.isSuccess == true) {
        productApplyForm = ProductApplyFormData.fromJson(response.data['data']);
        fetchCompanyData();
        clientData.fetchAgentClientData();
        notifyListeners();
      } else {
        print('response=> ${response.data}');
      }
    } catch (error) {
      print('adskjfbkjdsaf=> $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCompanyData() async {
    try {
      final response = await authRepository.agentCompanyData();
      if (response.isSuccess == true) {
        final List rawList = response.data['data'] ?? [];
        companyData = rawList
            .map((e) => CompanyData.fromJson(e))
            .toList();
        notifyListeners();
      } else {
        print('ladsfldsailfhsd=> ${response.data}');
      }
    } catch (error) {
      print('adskjfbkjdsaf=> $error');
    }
  }

  Future<void> productFormApply(BuildContext context, Product? product) async {
    try {
      isSubmitLoading = true;
      notifyListeners();

      Map<String, dynamic> body = {};
      body['product_id'] = product?.productId ?? 0;
      body['service_category_id'] = product?.serviceCategoryId;
      body['service_subcategory_id'] = product?.serviceSubcategoryId;

      body['client_id'] = selectedClientIds;
      body['company_id'] = selectedCompanyIds;

      controller.forEach((key, value) {
        body[key] = value.text.trim();
      });

      body.addAll(selectedDropdown);
      body.addAll(selectedRadio);
      selectedCheckbox.forEach((key, value) {
        body[key] = value;
      });

      for (var entry in selectedImages.entries) {
        if (entry.value != null) {
          body[entry.key] = await MultipartFile.fromFile(
            entry.value!.path,
            filename: entry.value!.path.split('/').last,
          );
        }
      }
      print("BODY => $body");
      final response = await authRepository.agentProductFormSubmit(body);
      print('akjdfkjdsafads=> ${response.isSuccess}');
      print('akjdfkjdsafads=> ${response.data}');
      print('akjdfkjdsafads=> ${response.error}');
      if (response.isSuccess == true) {
        clearForm();
        back(context);
      } else {
        print("Error => ${response.data}");
      }
    } catch (e) {
      print("ERROR => $e");
    } finally {
      isSubmitLoading = false;
      notifyListeners();
    }
  }

  void clearForm() {
    for (var item in controller.values) {
      item.clear();
    }
    selectedRadio.clear();
    selectedCheckbox.clear();
    selectedImages.clear();
    selectedDropdown.clear();
    selectedCompanyIds.clear();
    selectedClientIds.clear();

    selectedCompanyNames.clear();
    selectedClientNames.clear();

    notifyListeners();
  }
}
