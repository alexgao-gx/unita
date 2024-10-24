import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:unitaapp/common/http/interceptors/error_interceptor.dart';
import 'package:unitaapp/common/http/interceptors/header_interceptor.dart';

import 'environment.dart';
import 'interceptors/response_interceptor.dart';

class ApiClient {
  // Private constructor
  ApiClient._() {
    _init();
  }

  // Singleton instance
  static final ApiClient _instance = ApiClient._();

  // Factory constructor
  factory ApiClient() => _instance;

  late Dio _dio;

  _init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseApiUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Add an interceptor for handling token and errors

    _dio.interceptors.addAll([
      HeaderInterceptor(),
      PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          responseHeader: true),
      ResponseInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response> post(String path,
      {dynamic data,
      dynamic queryParameters,
      ProgressCallback? onSendProgress}) async {
    final response = await _dio.post(path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress);
    return response;
  }
}
