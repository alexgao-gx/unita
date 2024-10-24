/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:unitaapp/common/services/user_service.dart';

import '../utils/hive_box.dart';
import 'app_config_service.dart';
import 'auth_service.dart';

class ServiceInitManager {
  /// 必备数据的初始化操作
  static init() async {
    debugPrint('PluginsInit--start');
    await Hive.initFlutter();
    await HiveBox.initBoxes();

    Get.put(AppConfigService());

    Get.put(AuthService());
    Get.put(UserService());
    debugPrint('PluginsInit--end');
  }
}
