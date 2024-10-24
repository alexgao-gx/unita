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
import '../models/payment_model.dart';

/// Payment Module APIs
class PaymentAPI {
  /// Fetch Payments
  static Future<List<PaymentModel>> fetchPaymentList() async {
    var resp = await ApiClient().post('/api/app/user/creditCard/pageList', data: {});
    return List.from(resp.data['records']).map((e)=> PaymentModel.fromJson(e)).toList();
  }

  /// Add/Update Payment
  static Future addOrUpdatePayment({String? cardNo, String? cvv, String? expireDate, String? name, int? paymentId}) async {
    var resp = await ApiClient().post('/api/app/user/creditCard/save', data: {
      'cardNo': cardNo,
      'cvv': cvv,
      'expireDate': expireDate,
      'name': name,
      'id': paymentId,
    });
    return resp.data;
  }
}
