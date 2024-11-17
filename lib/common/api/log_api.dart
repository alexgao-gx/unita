/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description:
 */

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/address_model.dart';
import 'package:unitaapp/common/models/food_model.dart';
import 'package:unitaapp/common/models/home_log_info.dart';
import 'package:unitaapp/common/models/user_model.dart';
import 'package:unitaapp/common/utils/loading.dart';

import '../models/home_tips_model.dart';
import '../models/log_model.dart';
import '../models/log_req_model.dart';

enum LogType {
  FOOD,
  BEVERAGES,
  BOWEL_MOVEMENT,
  SYMPTOMS,
  WELLNESS_HEALTH,
  SKIN,
  MED,
  PERIOD
}

/// Log Module APIs
class LogAPI {
  /// Fetch Foods
  static Future<List<FoodModel>> searchFoods(String keywords) async {
    var resp = await ApiClient()
        .get('/log/foodSearch', queryParameters: {'name': keywords});
    return List.from(resp.data).map((e) => FoodModel.fromJson(e)).toList();
  }

  /// Fetch Log Info
  static Future<LogModel> fetchLogInfo({
    List<LogType>? logTypes,
    DateTime? logDate,
    String? userId, // Added userId as a parameter
  }) async {
    var resp = await ApiClient().get('/log/info', queryParameters: {
      'logType': logTypes?.map((e) => e.name).toList().join(','),
      'logDate': DateUtil.formatDate(logDate ?? DateTime.now(),
          format: DateFormats.y_mo_d),
      'userId': userId, // Include userId in query parameters
    });
    return LogModel.fromJson(resp.data);
  }

  /// Save Log Info
  static Future saveLogInfo(LogReqModel logReqData, {String? userId}) async {
    // Include userId in the request data
    Map<String, dynamic> data = logReqData.toJson();
    data['userId'] = userId; // Add userId to the data map

    var resp = await ApiClient().post('/log/save', data: data);
    return resp.data;
  }

  /// Remove Bowel Movement Log Info
  static Future removeBowelMovementLogInfo({required int logId}) async {
    var resp = await ApiClient()
        .post('/log/removeBowelMovement', queryParameters: {'id': logId});
    Loading.toast(resp.statusMessage ?? '');
    return resp.data;
  }

  /// Fetch Medications
  static Future<List<MedicationModel>> searchMedication(String keywords) async {
    var resp = await ApiClient()
        .get('/log/medSearch', queryParameters: {'name': keywords});
    return List.from(resp.data)
        .map((e) => MedicationModel.fromJson(e))
        .toList();
  }

  /// Upload Meal File
  static Future<List<FoodModel>> uploadMealFile(File file,
      {ProgressCallback? onSendProgress}) async {
    final formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(file.path, filename: basename(file.path))
    });
    final resp = await ApiClient().post('/log/foodIdentify',
        data: formData, onSendProgress: onSendProgress);
    return List.from(resp.data['food'])
        .map((e) => FoodModel.fromJson(e))
        .toList();
  }
}
