import 'dart:developer';

import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/service_category_response.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';
import 'package:flutter/cupertino.dart';

class AgentPortfolioProvider extends BaseProvider {
  List<ServiceCategoryData> serviceCategoryData = [];
  List<ServiceSubCategoryData> serviceSubCategoryData = [];

  bool categoryLoading = false;
  bool subCategoryLoading = false;

  /// SELECTED CATEGORY
  int? selectedCategoryId;


  Future<void> fetchCategroyPortfolio() async {
    try {

      categoryLoading = true;
      notifyListeners();

      final response =
      await authRepository
          .getAgentPortfolioCategory();

      if(response.isSuccess == true){
        final List data = response.data['data'] ?? [];
        serviceCategoryData = data.map((value)=>ServiceCategoryData.fromJson(value) ).toList();
      }
        await fetchSubCategoryPortfolio(
          selectedCategoryId ?? 0,
        );

    } catch (e) {

      log("CATEGORY ERROR => $e");

    } finally {

      categoryLoading = false;
      notifyListeners();
    }
  }

  /// FETCH SUB CATEGORY
  Future<void> fetchSubCategoryPortfolio(
      int serviceId,
      ) async {

    try {

      selectedCategoryId = serviceId;

      subCategoryLoading = true;
      notifyListeners();

      log(
        "SUB CATEGORY API CALL START => $serviceId",
      );

      final response =
      await authRepository
          .getAgentPortfolioSubCategory(
        serviceId,
      );

      if(response.isSuccess == true){
        final List data = response.data['data'] ?? [];
        serviceSubCategoryData = data.map((value)=>ServiceSubCategoryData.fromJson(value) ).toList();
      }

    } catch (e) {

      log("SUB CATEGORY ERROR => $e");

    } finally {

      subCategoryLoading = false;
      notifyListeners();

      log("SUB CATEGORY LOADING END");
    }
  }
}
