import 'package:base_module/core/app_config.dart';

import '../core/network/api_client.dart';
import '../core/network/base_repository.dart';
import '../core/network/result.dart';

class AuthRepository extends BaseRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<Result<dynamic>> signInSendOtp(Map<String, dynamic> body) {
    return safeApiCall(() async {
      final response = await apiClient.postDio(
        AppConfig.actionSendOtp,
        body: body,
      );
      return response.data;
    });
  }

  Future<Result<dynamic>> signInVerifyOtp(Map<String, dynamic> body) {
    return safeApiCall(() async {
      final response =
          await apiClient.postDio(AppConfig.actionVerifyOtp, body: body);
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

 Future<Result<dynamic>> courseDetails(Map<String,dynamic> queryParameters) {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionCoursesDetails,
         queryParameters:queryParameters );
      return response.data;
    });
  }

 Future<Result<dynamic>> courseCategory() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionCoursesCategory);
      return response.data;
    });
  }

 Future<Result<dynamic>> courseLevel() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionCoursesLevel);
      return response.data;
    });
  }

 Future<Result<dynamic>> courseLanguage() {
    return safeApiCall(() async {
      final response = await apiClient.getDio(AppConfig.actionCoursesLanguage);
      return response.data;
    });
  }


}
