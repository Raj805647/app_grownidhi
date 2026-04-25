import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  ) {
    debugPrint("🌐 Base URL: ${AppConfig.baseUrl}");
  }

  Future<Response> postDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
      }) async {
    final data = isFormData && body is Map<String, dynamic>
        ? FormData.fromMap(body)
        : body;

    return await dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> getDio(
      String endpoint, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      }) async {
    return await dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<http.Response> getHttp(String url) async {
    return await http.get(Uri.parse(url));
  }

  Future<http.Response> postHttp(String url, Map<String, dynamic> body) async {
    return await http.post(Uri.parse(url), body: body);
  }
}
