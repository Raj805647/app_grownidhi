import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/portfolio_details_response.dart';
import 'package:provider/provider.dart';

class PortfolioProvider extends BaseProvider{
  bool isLoading = false;
  List<PortfolioDetailsData> portfolioList = [];
  Map<String,dynamic> formDetails = {};


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

        portfolioList = data.map((e) => PortfolioDetailsData.fromJson(e)).toList();
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