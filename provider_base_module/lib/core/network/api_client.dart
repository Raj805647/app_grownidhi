import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../app_config.dart';
import '../storage/storage_service.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  ) {
    debugPrint("🌐 Base URL: ${AppConfig.baseUrl}");
  }

  /// ========================= POST =========================
  Future<Response> postDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        bool requiresAuth = true,
      }) async {
    try {
      final data = isFormData && body is Map<String, dynamic>
          ? FormData.fromMap(body)
          : body;

      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      debugPrint("📤 POST => $endpoint");
      debugPrint("BODY => $body");

      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      debugPrint("✅ RESPONSE => ${response.data}");

      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// ========================= GET =========================
  Future<Response> getDio(
      String endpoint, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool requiresAuth = true,
      }) async {
    try {
      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      debugPrint("📥 GET => $endpoint");

      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      debugPrint("✅ RESPONSE => ${response.data}");

      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// ========================= PUT =========================
  Future<Response> putDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        bool requiresAuth = true,
      }) async {
    try {
      final data = isFormData && body is Map<String, dynamic>
          ? FormData.fromMap(body)
          : body;

      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      debugPrint("📝 PUT => $endpoint");
      debugPrint("BODY => $body");

      final response = await dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      debugPrint("✅ RESPONSE => ${response.data}");

      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// ========================= PATCH =========================
  Future<Response> patchDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        bool requiresAuth = true,
      }) async {
    try {
      final data = isFormData && body is Map<String, dynamic>
          ? FormData.fromMap(body)
          : body;

      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      debugPrint("✏ PATCH => $endpoint");
      debugPrint("BODY => $body");

      final response = await dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      debugPrint("✅ RESPONSE => ${response.data}");

      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// ========================= DELETE =========================
  Future<Response> deleteDio(
      String endpoint, {
        dynamic body,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        bool requiresAuth = true,
      }) async {
    try {
      final updatedHeaders = await _attachAuthHeader(
        headers,
        requiresAuth: requiresAuth,
      );

      debugPrint("🗑 DELETE => $endpoint");

      final response = await dio.delete(
        endpoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: updatedHeaders),
      );

      debugPrint("✅ RESPONSE => ${response.data}");

      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// ========================= HTTP GET =========================
  Future<http.Response> getHttp(
      String url, {
        bool requiresAuth = true,
      }) async {
    final headers = await _httpHeaders(
      requiresAuth: requiresAuth,
    );

    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  /// ========================= HTTP POST =========================
  Future<http.Response> postHttp(
      String url,
      Map<String, dynamic> body, {
        bool requiresAuth = true,
      }) async {
    final headers = await _httpHeaders(
      requiresAuth: requiresAuth,
    );

    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  /// ========================= HTTP PUT =========================
  Future<http.Response> putHttp(
      String url,
      Map<String, dynamic> body, {
        bool requiresAuth = true,
      }) async {
    final headers = await _httpHeaders(
      requiresAuth: requiresAuth,
    );

    return await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  }

  /// ========================= HTTP DELETE =========================
  Future<http.Response> deleteHttp(
      String url, {
        bool requiresAuth = true,
      }) async {
    final headers = await _httpHeaders(
      requiresAuth: requiresAuth,
    );

    return await http.delete(
      Uri.parse(url),
      headers: headers,
    );
  }

  /// ========================= COMMON HEADERS =========================
  Future<Map<String, dynamic>> _attachAuthHeader(
      Map<String, dynamic>? headers, {
        bool requiresAuth = true,
      }) async {
    final updatedHeaders = Map<String, dynamic>.from(
      headers ?? {},
    );

    updatedHeaders['Accept'] = 'application/json';

    if (requiresAuth) {
      final token = await StorageService.getUserToken();

      if (token != null && token.isNotEmpty) {
        updatedHeaders['Authorization'] = 'Bearer $token';
      }
    }

    return updatedHeaders;
  }

  /// ========================= HTTP HEADERS =========================
  Future<Map<String, String>> _httpHeaders({
    bool requiresAuth = true,
  }) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (requiresAuth) {
      final token = await StorageService.getUserToken();

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  /// ========================= ERROR HANDLE =========================
  void _handleDioError(DioException e) {
    debugPrint("❌ STATUS => ${e.response?.statusCode}");
    debugPrint("❌ ERROR => ${e.response?.data}");
    debugPrint("❌ MESSAGE => ${e.message}");
  }
}