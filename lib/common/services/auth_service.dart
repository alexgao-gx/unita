/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'package:get/get.dart';
import 'package:unitaapp/common/api/auth_api.dart';
import 'package:unitaapp/common/api/user_api.dart';
import 'package:unitaapp/common/models/index.dart';
import 'package:unitaapp/common/models/user_model.dart';
import 'package:unitaapp/common/services/app_config_service.dart';
import 'package:unitaapp/common/services/user_service.dart';

import '../utils/hive_box.dart';

/// 鉴权相关服务
/// 初始化时,应该从storage出读取user对象的值,用来确保路由中间件中可同步取出isAuth状态
class AuthService extends GetxService {
  static const tag = 'AuthService';

  final Rx<AuthModel> _auth = AuthModel().obs;

  setAuth(AuthModel auth) async {
    HiveBox.auth.setAuth(auth.toJson());
    _auth.value = auth;
    if (isAuth) {
      /// 每次鉴权成功后，同步用户信息以及该用户动态数据
      if (Get.isRegistered<UserService>()) {
        Get.find<UserService>().fetchUserInfo();
      } else {
        Get.put(UserService()).fetchUserInfo();
      }
      if (Get.isRegistered<AppConfigService>()) {
        Get.find<AppConfigService>().fetchConfigs();
      } else {
        Get.put(AppConfigService()).fetchConfigs();
      }
      // Fetch user details and store them in UserBox
      final userInfo = await UserAPI
          .fetchUserInfo(); // Assuming this API call exists to get user info

      HiveBox.user.setUser(userInfo); // Store user info in UserBox
    }
  }

  /// 判断是否登录
  bool get isAuth => _auth.value.isAuth ?? false;

  /// Tokens，the value is an empty string when not login.
  String? get idToken => _auth.value.idToken;
  String? get accessToken => _auth.value.accessToken;
  String? get refreshToken => _auth.value.refreshToken;

  @override
  void onInit() {
    super.onInit();
    loadAuth();
  }

  /// 从localStorage中读取auth info.
  Future<void> loadAuth() async {
    if (!_auth.value.isAuth && HiveBox.auth.containsAuth()) {
      final authEntity = AuthModel.fromJson(HiveBox.auth.getAuth());
      setAuth(authEntity);
    }
  }

  Future logout() async {
    await AuthAPI.logout();
    await cleanAuth();
  }

  Future cleanAuth() async {
    setAuth(AuthModel());
    HiveBox.auth.clearAuth();
  }
}
