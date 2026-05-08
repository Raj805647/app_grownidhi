import 'package:base_module/core/app_config.dart';
import 'package:flutter/cupertino.dart';

import '../core/network/api_client.dart';
import '../core/network/base_repository.dart';
import '../core/network/result.dart';

class AuthRepository extends BaseRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<Result<dynamic>> signIn(Map<String, dynamic> body) {
    return safeApiCall(() async {
      debugPrint("SIGN IN REQUEST: $body");

      final response = await apiClient.postDio(
        AppConfig.actionSignIn,
        requiresAuth: false,
        body: body,
      );

      debugPrint("SIGN IN RESPONSE: ${response.data}");

      return response.data;
    });
  }

  Future<Result<dynamic>> signUp(Map<String, dynamic> body) {
    return safeApiCall(() async {
      final response =
          await apiClient.postDio(AppConfig.actionSignUp,requiresAuth: false, body: body);
      return response.data;
    });
  }

  Future<Result<dynamic>> userProfile() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionProfile);
      return response.data;
    });
  }

  Future<Result<dynamic>> courseCategory() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionServiceCategory);
      print('akdbfkjdsa=> ${response.statusCode}');
      print('akdbfkjdsa=> ${response.data}');
      return response.data;
    });
  }

  Future<Result<dynamic>> subCategory(int subId) {
    return safeApiCall(() async {
      final response = await apiClient
          .getDio('${AppConfig.actionServiceSubsCategory}/$subId');
      return response.data;
    });
  }

  Future<Result<dynamic>> productDetails(int categoryId, int subCategoryId, int pageNo, pageLimit) {
    return safeApiCall(() async {
      final response = await apiClient
          .getDio('${AppConfig.actionServiceProductDetails}/category_id=$categoryId/subCategory_id=$subCategoryId?page=$pageNo&limit=$pageLimit');
      return response.data;
    });
  }

  Future<Result<dynamic>> formStateDetails(int productId) {
    return safeApiCall(() async {
      final response = await apiClient
          .getDio('${AppConfig.actionFormStateDetails}/product_id=$productId');
      return response.data;
    });
  }

  Future<Result<dynamic>> policyDetails() {
    return safeApiCall(() async {
      final response = await apiClient
          .getDio(AppConfig.actionPolicyDetails);
      return response.data;
    });
  }

  Future<Result<dynamic>> updateProfile(Map<String, dynamic> body) {
    return safeApiCall(() async {
      final response = await apiClient.postDio(AppConfig.actionUpdateProfile,body: body);
      return response.data;
    });
  }

  Future<Result<dynamic>> submitFormDetails(Map<String, dynamic> body) {
    return safeApiCall(() async {
      final response = await apiClient.postDio(AppConfig.actionSubmitFormDetails,body: body, isFormData: true);
      return response.data;
    });
  }
}
