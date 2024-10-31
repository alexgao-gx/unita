/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:unitaapp/common/http/api_client.dart';
import 'package:unitaapp/common/models/user_model.dart';

import '../models/message_model.dart';

/// User Module APIs
class UserAPI {
  /// Fetch User Info
  static Future<UserModel> fetchUserInfo() async {
    var resp = await ApiClient().get('/user/info');
    return resp.data != null ? UserModel.fromJson(resp.data) : UserModel();
  }

  /// Upload File
  static Future<String> uploadFile(File file,
      {ProgressCallback? onSendProgress}) async {
    final formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(file.path, filename: basename(file.path))
    });
    final response = await ApiClient().post('/file/uploadImg',
        data: formData, onSendProgress: onSendProgress);
    return response.data;
  }

  /// Update User Info
  static Future updateUserInfo(UserModel newUserInfo) async {
    final parameters = newUserInfo.toJson();
    parameters.keys
        .where((k) => parameters[k] == null)
        .toList()
        .forEach(parameters.remove);
    final resp = await ApiClient().post('/user/update', data: parameters);
    return resp.data;
  }

  /// Fetch Messages
  static Future<List<MessageModel>> fetchNotifications({int page = 1}) async {
    var resp =
        await ApiClient().get('/message/list', queryParameters: {'page': page});
    return resp.data['records'] != null
        ? List.from(resp.data['records'])
            .map((e) => MessageModel.fromJson(e))
            .toList()
        : <MessageModel>[];
  }
}
