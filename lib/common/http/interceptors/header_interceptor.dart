import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/services/auth_service.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.connectTimeout = Duration(seconds: 15);
    options.receiveTimeout = Duration(seconds: 45);
    // Add common headers
    options.headers["User-Agent"] = 'UNITA';
    options.headers["X-FROM"] = 'APP';
    options.headers['Accept-Language'] = Get.deviceLocale?.languageCode == 'zh' ? 'zh_CN' : 'en_US';
    // Add authorization token if available
    options.headers['ACCESSTOKEN'] = '${Get.find<AuthService>().accessToken}';
    options.headers['REFRESHTOKEN'] = '${Get.find<AuthService>().refreshToken}';
    options.headers['IDTOKEN'] = '${Get.find<AuthService>().idToken}';

    super.onRequest(options, handler);
  }
}