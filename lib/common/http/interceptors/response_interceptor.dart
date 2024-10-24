
import 'dart:convert';

import 'package:dio/dio.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Parse and handle response data
    // Assuming the API returns a JSON object with a "code" and "data" field
    if (response.data is Map) {
      final Map<String, dynamic> responseData = response.data;
      final int code = responseData['status'];
      final String message = responseData['message'];
      final dynamic data = responseData['data'];
      if (response.statusCode == 200) {
        if (code == 200) {
          response.statusMessage = message;
          response.data = data;
          // Success case
          handler.resolve(response);
        } else {
          // Handle API specific error
          handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: message,
          ), true);
        }
      } else {
        // Handle non-200 HTTP response
        handler.reject(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: message,
        ), true);
      }
    } else {
      response.data = jsonDecode(response.data);
      handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      ), true);
    }

  }
}