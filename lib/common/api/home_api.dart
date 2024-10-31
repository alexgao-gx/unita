/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/models/home_log_info.dart';
import 'package:unitaapp/common/models/user_model.dart';

import '../models/home_tips_model.dart';

/// Home Module APIs
class HomeAPI {
  /// Fetch Home Tips
  static Future<HomeTipsModel> fetchHomeTips() async {
    var resp = await ApiClient().get('/home/tips');
    return resp.data != null
        ? HomeTipsModel.fromJson(resp.data)
        : HomeTipsModel();
  }

  /// Fetch Home Log Info
  static Future<HomeLogInfoModel> fetchHomeLogInfo() async {
    var resp = await ApiClient().get('/home/logInfo');
    return resp.data != null
        ? HomeLogInfoModel.fromJson(resp.data)
        : HomeLogInfoModel();
  }
}
