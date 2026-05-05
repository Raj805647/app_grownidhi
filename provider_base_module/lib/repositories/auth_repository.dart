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
      final response =
          await apiClient.postDio(AppConfig.actionSignIn, body: body);
      return response.data;
    });
  }

  Future<Result<dynamic>> signUp(Map<String, dynamic> body) {
    return safeApiCall(() async {

      final response =
      await apiClient.postDio(AppConfig.actionSignUp, body: body);
      return response.data;
    });
  }

  Future<Result<dynamic>> userProfile(String userToken) {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionProfile,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          });
      return response.data;
    });
  }

  Future<Result<dynamic>> courseCategory() {
    return safeApiCall(() async {
      final response =
      await apiClient.getDio(AppConfig.actionServiceCategory);

      return response.data;
    });
  }

  Future<Result<dynamic>> subCategory(int subId) {
    return safeApiCall(() async {
      final response =
      await apiClient.getDio('${AppConfig.actionServiceSubsCategory}/$subId');
      return response.data;
    });
  }

    Future<Result<dynamic>> updateProfile(String userToken, Map<String,dynamic> body) {
    return safeApiCall(() async {
      final response = await apiClient.postDio(AppConfig.actionUpdateProfile,
          body: body,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $userToken'
          });
      return response.data;
    });
  }

}
