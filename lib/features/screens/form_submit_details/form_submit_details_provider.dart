import 'package:base_module/base_module.dart';
import 'package:base_module/core/models/form_state_details_response.dart';

class FormSubmitDetailsProvider extends BaseProvider{
  bool isLoading = false;
  List<Fields> formDataList = [];

  Future<void> fetchFormStateDetails(int productId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await authRepository.formStateDetails(productId);
      print('akdjbfkjbdsakbf=> ${response.isSuccess}');
      print('akdjbfkjbdsakbf=> ${response.data}');
      print('akdjbfkjbdsakbf=> ${response.error}');

      if (response.isSuccess == true && response.data != null) {
        final List rawList = response.data['data']['fields'] ?? [];

        formDataList = rawList.map((e) => Fields.fromJson(e)).toList();

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