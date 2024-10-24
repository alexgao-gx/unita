import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/auth_service.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle specific error types
    Map<String, dynamic> responseData = {};
    if (err.response?.data is Map) {
      responseData = err.response?.data;
    } else if (err.response?.data is String) {
      responseData = jsonDecode(err.response?.data);
    }
    final int statusCode = responseData['status'];
    final String message = responseData['message'] ?? err.message;
    
    if (statusCode == 401) {
      // Handle unauthorized error, e.g., token refresh
      if (Get.currentRoute != RouteNames.signUp) {
        Loading.toast(message);
        Get.find<AuthService>().cleanAuth();
        Get.offAllNamed(RouteNames.signUp);
      }
    } else if (err.type == DioExceptionType.unknown) {
      // Handle network errors
      Loading.toast(message);
    } else if (err.type == DioExceptionType.badResponse) {
      // Handle network errors
      Loading.toast(message);
    } else if (err.type == DioExceptionType.receiveTimeout) {
      // Handle network errors
      Loading.toast(message);
    }
    super.onError(err, handler);
  }
}