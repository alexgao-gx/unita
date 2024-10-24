/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */

import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/api/auth_api.dart';
import 'package:unitaapp/common/api/user_api.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/index.dart';
import 'package:unitaapp/common/models/user_model.dart';

import '../utils/file_util.dart';
import '../utils/hive_box.dart';
import '../utils/permissions_util.dart';

class UserService extends GetxService {
  static const tag = 'UserService';

  final Rx<UserModel> _userInfo = UserModel().obs;

  /// Username
  String get username => _userInfo.value.username ?? '--';

  /// Coins
  int get coins => _userInfo.value.coin ?? 0;

  /// Username
  String get headImageUrl => _userInfo.value.headImg ?? '';

  /// Age
  int get age => Validators.calculateAge(
      DateUtil.getDateTime(_userInfo.value.birth ?? '2000-02-08') ??
          DateTime.now());

  /// Gender
  String get gender => _userInfo.value.gender ?? '';

  /// Weight
  String get weight => _userInfo.value.weight ?? '';

  /// WeightUnit
  String get weightUnit => _userInfo.value.weightUnit ?? '';

  /// Height
  String get height => _userInfo.value.tall ?? '';

  /// HeightUnit
  String get heightUnit => _userInfo.value.tallUnit ?? '';

  /// Selected Allergies Ids
  List<String> get allergiesIds => _userInfo.value.allergies?.split(',') ?? [];

  /// Fetch User Info.
  Future<void> fetchUserInfo() async {
    _userInfo.value = await UserAPI.fetchUserInfo();
  }

  /// 更新头像
  /// isFromGallery 是否从相册选择图片
  Future updateAvatar(bool isFromGallery) async {
    File? pickFile;
    if (isFromGallery) {
      if (!await PermissionsUtil.requestStoragePermission()) {
        return;
      }
      pickFile = await FileUtil.getGalleryImageDirectly();
    } else {
      if (!await PermissionsUtil.requestCameraPermission()) {
        return;
      }
      pickFile = await FileUtil.takeCameraPhotoDirectly();
    }
    if (pickFile != null) {
      final croppedFile = await FileUtil.cropImageByUpdateAvatar(pickFile.path);
      if (croppedFile != null) {
        // Loading.showProgress(0);
        Loading.show('Uploading...'.tr);
        final compressedFile = await FileUtil.compressImageToBytes(croppedFile,
            maxBytes: 500 * 1000);
        final avatarUrl = await UserAPI.uploadFile(compressedFile,
            onSendProgress: (count, total) {
          // Loading.showProgress(count / total);
        });
        final userInfo = UserModel(headImg: avatarUrl);
        await updateUserInfo(userInfo);
      }
    }
    Loading.dismiss();
  }

  Future updateUserInfo(UserModel newUserInfo) async {
    await UserAPI.updateUserInfo(newUserInfo);
    await fetchUserInfo();
  }
}
