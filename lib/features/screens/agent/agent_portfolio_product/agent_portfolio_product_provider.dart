import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/product_service_response.dart';
import 'package:flutter/cupertino.dart';

class AgentPortfolioProductProvider extends BaseProvider {
  bool isLoading = false;
  List<ProductListData> productListData = [];

  bool productLoading = false;

  Future<void> fetchAgentPortfolioProduct({
    required int categoryId,
    required int subCategoryId,
  }) async {

    try {

      productLoading = true;
      notifyListeners();

      debugPrint(
        "PRODUCT API CALL => categoryId: $categoryId, subCategoryId: $subCategoryId",
      );

      final response =
      await authRepository
          .getAgentPortfolioPortFolio(
        categoryId,
        subCategoryId,
      );

      debugPrint(
        "PRODUCT RESPONSE => ${response.toString()}",
      );



      if(response.isSuccess == true){
        final List data = response.data['data'] ?? [];
        productListData = data.map((value)=>ProductListData.fromJson(value) ).toList();
      }

      debugPrint(
        "PRODUCT LIST LENGTH => ${productListData.length}",
      );

    } catch (e) {

      debugPrint(
        "PRODUCT ERROR => $e",
      );

    } finally {

      productLoading = false;
      notifyListeners();
    }
  }
}
