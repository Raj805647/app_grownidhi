import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:flutter/material.dart';

class ProductProvider extends BaseProvider {
  final searchController = TextEditingController();
  bool isLoading = false;
  int pageNo = 1;
  int pageLimit = 100;
  List<ServiceProductsData> products = [];

  Future<void> fetchSubCategory(int categoryId,int subCategoryId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.productDetails(subCategoryId,categoryId,pageNo, pageLimit);
      print('akdbfkjabsdbf=>${response.isSuccess}');
      print('akdbfkjabsdbf=>${response.data}');
      print('akdbfkjabsdbf=>${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List data = response.data['data'] ?? [];

        products = data.map((e) => ServiceProductsData.fromJson(e)).toList();
      }
    } catch (error, stackTrace) {
      print("🔥 Error: $error");
      print("📍 StackTrace: $stackTrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }}
