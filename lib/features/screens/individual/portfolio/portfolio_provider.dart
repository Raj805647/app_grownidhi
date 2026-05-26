import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/individual_product_policies_response.dart';
import 'package:provider/provider.dart';

class PortfolioProvider extends BaseProvider{
  bool isLoading = false;
  List<ProductPoliciesData> portfolioList = [];


  Future<void> fetchPortfolioData() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.policyDetails();
      print('akdjbfkjbdsakbf=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List data = response.data['data'] ?? [];

        portfolioList = data.map((e) => ProductPoliciesData.fromJson(e)).toList();
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