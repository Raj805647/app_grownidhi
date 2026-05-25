import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/service_category_response.dart';
import 'package:base_module/core/models/service_sub_category_response.dart';

class ShowCateSubcateDataProvider extends BaseProvider {
  bool isLoading = false;
  bool isSubLoading = false;
  List<ServiceCategoryData> categoryList = [];
  List<ServiceSubCategoryData> subCategoryList = [];

  int selectedFilter = 0;

  void changeFilter(int value) {
    selectedFilter = value;
    fetchSubCategory(value);
    notifyListeners();
  }

  Future<void> fetchServiceCategory() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.courseCategory();
      print('akdjbfkjbdsakbf=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List data = response.data['data'] ?? [];

        categoryList = data.map((e) => ServiceCategoryData.fromJson(e)).toList();
      }
    } catch (error, stackTrace) {
      print("🔥 Error: $error");
      print("📍 StackTrace: $stackTrace");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubCategory(int categoryId) async {
    try {
      isSubLoading = true;
      notifyListeners();

      final response = await authRepository.subCategory(categoryId);
      print('asdiufgudsagugfu=> ${categoryId}');
      print('asdiufgudsagugfu=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List data = response.data['data'] ?? [];

        subCategoryList = data.map((e) => ServiceSubCategoryData.fromJson(e)).toList();
      }
    } catch (error, stackTrace) {
      print("🔥 Error: $error");
      print("📍 StackTrace: $stackTrace");
    } finally {
      isSubLoading = false;
      notifyListeners();
    }
  }


}
