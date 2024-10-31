/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description:
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/models/address_model.dart';
import 'package:unitaapp/common/models/assessment_page_model.dart';
import 'package:unitaapp/common/models/home_log_info.dart';
import 'package:unitaapp/common/models/user_model.dart';
import 'package:unitaapp/common/services/assessment_service.dart';

import '../models/assessment_model.dart';
import '../models/home_tips_model.dart';

/// Assessment Module APIs
class AssessmentAPI {
  /// Fetch Assessments
  static Future<List<AssessmentModel>> fetchAssessmentList1(
      AssessmentType type) async {
    var resp = await ApiClient()
        .get('/assessment/list', queryParameters: {'type': type.name});
    return resp.data != null
        ? List.from(resp.data).map((e) => AssessmentModel.fromJson(e)).toList()
        : <AssessmentModel>[];
  }

  /// Fetch Assessments
  static Future<List<AssessmentPageModel>> fetchAssessmentList(
      AssessmentType type) async {
    var resp = await ApiClient()
        .get('/assessment/list', queryParameters: {'type': type.name});
    return resp.data != null
        ? List.from(resp.data)
            .map((e) => AssessmentPageModel.fromJson(e))
            .toList()
        : <AssessmentPageModel>[];
  }

  /// Add/Update Address
  static Future addOrUpdateAddress(
      {String? phone,
      String? name,
      String? address,
      String? room,
      String? prefix,
      String? zipCode,
      int? addressId}) async {
    var resp = await ApiClient().post('/user/address/save', data: {
      'name': name,
      'phone': phone,
      'address': address,
      'prefix': prefix,
      'room': room,
      'zipCode': zipCode,
      'id': addressId,
    });
    return resp.data;
  }
}
