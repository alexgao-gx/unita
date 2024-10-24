/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/plan_mind_model.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

import '../models/plan_model.dart';

/// Plan APIs
class PlanAPI {
  /// Mind Info
  static Future<PlanMindModel> fetchMindInfo() async {
    var resp = await ApiClient().get('/api/app/plan/mind/info');
    return resp.data != null ? PlanMindModel.fromJson(resp.data) : PlanMindModel();
  }

  /// Save Mind
  static Future saveMindInfo({String? code}) async {
    var resp = await ApiClient().post('/api/app/plan/saveMind', queryParameters: {'code': code});
    Loading.toast(resp.statusMessage ?? '');
    return resp.data;
  }

  /// Body Info
  static Future<PlanMindModel> fetchBodyInfo() async {
    var resp = await ApiClient().get('/api/app/plan/body/info');
    return resp.data != null ? PlanMindModel.fromJson(resp.data) : PlanMindModel();
  }

  /// Save Body
  static Future saveBodyInfo({String? code}) async {
    var resp = await ApiClient().post('/api/app/plan/saveBody', queryParameters: {'code': code});
    Loading.toast(resp.statusMessage ?? '');
    return resp.data;
  }

  /// Plan Info
  static Future<PlanModel> fetchPlanInfo() async {
    var resp = await ApiClient().get('/api/app/plan/info');
    return resp.data != null ? PlanModel.fromJson(resp.data) : PlanModel();
  }
}
