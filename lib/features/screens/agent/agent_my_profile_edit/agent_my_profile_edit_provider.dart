import 'dart:io';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/agent_profile_response.dart';
import 'package:base_module/core/models/company_list_response.dart';
import 'package:base_module/core/models/product_service_response.dart';
import 'package:base_module/core/models/user_response.dart';
import 'package:base_module/image_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AgentMyProfileEditProvider extends BaseProvider {
  UserData userData = UserData();
  bool isLoading = false;
  AgentProfileData agentProfileData = AgentProfileData();
  List<CompanyListData> companyListData = [];
  List<String> selectedCompanies = [];
  List selectedCompanyIds = [];

  List<ProductListData> productListData = [];
  List<String> selectedProducts = [];
  List selectedProductIds = [];

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

  void changeGender(String? value) {
    if (value != null) {
      genderController.text = value;
    }
  }

  void changeMaritalStatus(String? value) {
    if (value != null) {
      maritalStatusController.text = value;
    }
  }

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

  Future<void> fetchCompanyList() async {
    userData = await StorageService.getUserData() ?? UserData();
    autoFetchUserData();
    final response = await authRepository.companyListData();
    print('adflnldsan');
    print(response.error);
    print(response.data);
    if (response.isSuccess == true) {
      final List rawList = response.data['data'] ?? [];
      companyListData = rawList
          .map((e) => CompanyListData.fromJson(e))
          .toList();
      notifyListeners();
    } else {
      print(response.data);
    }
  }

  void autoFetchUserData() {
    fullNameController.text = userData.name ?? '';
    emailController.text = userData.email ?? '';
    mobileNumberController.text = userData.number ?? '';
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    final response = await authRepository.productListData(selectedCompanyIds);
    print('akdjnfkjdsakf');
    print(response.isSuccess);
    print(response.data);
    if (response.isSuccess == true) {
      final List rawList = response.data['data'] ?? [];
      productListData = rawList
          .map((e) => ProductListData.fromJson(e))
          .toList();
      notifyListeners();
    } else {
      print(response.data);
    }
  }

  Future<void> updateCreateProfile(BuildContext context) async {
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
        "experience_document": experienceDocument != null
            ? await MultipartFile.fromFile(
                experienceDocument!.path,
                filename: experienceDocument!.path.split('/').last,
              )
            : null,

        "education_document": educationDocument != null
            ? await MultipartFile.fromFile(
                educationDocument!.path,
                filename: educationDocument!.path.split('/').last,
              )
            : null,

        "occupation": occupationController.text.trim(),
        "designation": designationController.text.trim(),
        "experience": experienceController.text.trim(),
        "education": educationController.text.trim(),

        "annual_income": annualIncomeController.text.trim(),
        "monthly_income": monthlyIncomeController.text.trim(),

        'company_ids[]': selectedCompanyIds,
        'product_ids[]': selectedProductIds,
      };

      print('adbfhbdsavgfhdsagfydsa');
      print(data);

      final response = await authRepository.agentUpdateProfile(data);
      print('asdkfkdsagkfsdfj');
      print(response.isSuccess);
      print(response.data);

      if (response.isSuccess == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
        back(context);
        clearProfileData();
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

  void clearProfileData() {
    /// Clear Text Controllers
    fullNameController.clear();
    fatherNameController.clear();
    mobileNumberController.clear();
    alternateMobileNumberController.clear();
    emailController.clear();
    dobController.clear();
    genderController.clear();
    maritalStatusController.clear();

    addressLine1Controller.clear();
    addressLine2Controller.clear();
    cityController.clear();
    stateController.clear();
    pincodeController.clear();
    countryController.clear();

    occupationController.clear();
    designationController.clear();
    experienceController.clear();
    educationController.clear();

    annualIncomeController.clear();
    monthlyIncomeController.clear();

    /// Clear Files
    experienceDocument = null;
    educationDocument = null;

    /// Clear Company Selection
    selectedCompanies.clear();
    selectedCompanyIds.clear();

    /// Clear Product Selection
    selectedProducts.clear();
    selectedProductIds.clear();

    /// Optional Product List Reset
    productListData.clear();

    notifyListeners();
  }
}
