import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';
import 'package:base_module/core/models/portfolio_details_response.dart';

class ProductDetailProvider extends BaseProvider {
  bool isLoading = false;
  List<PortfolioDetailsData> portfolioList = [];


  Future<void> fetchServiceCategory() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.policyDetails();
      print('akdjbfkjbdsakbf=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List data = response.data['data'] ?? [];

        portfolioList = data.map((e) => PortfolioDetailsData.fromJson(e)).toList();
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

