import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unitaapp/common/index.dart';

class PermissionsUtil {
  static Future<bool> openSystemSettings() async => await openAppSettings();


  static Future<bool> locationStatusIsGranted() async {
    return await Permission.location.isGranted;
  }


  static Future<bool> requestCameraPermission() async {
    if (await Permission.camera.request().isPermanentlyDenied) {
      showCameraPermissionDialog();
    }
    return await Permission.camera.isGranted;
  }

  static Future showCameraPermissionDialog() => Get.dialog(
      CupertinoAlertDialog(
        title: TextWidget(text: 'You have not enabled camera permissions'.tr),
        content: TextWidget(text: 'Do you want to go to settings to open?'.tr),
        actions: [
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.grey[600]),
            onPressed: () => Get.back(),
            child: TextWidget(text: 'Cancel'.tr),
          ),
          CupertinoDialogAction(
            child: TextWidget(text: 'Done'.tr),
            onPressed: () async {
              Get.back();
              await openAppSettings();
            },
          ),
        ],
      ),
      barrierDismissible: false);

  static Future<bool> requestStoragePermission() async {
    final Permission permission =
        Platform.isAndroid ? Permission.storage : Permission.photos;
    if (await permission.request().isPermanentlyDenied) {
      showStoragePermissionDialog();
    }
    return await permission.isGranted || await permission.isLimited;
  }

  static Future showStoragePermissionDialog() => Get.dialog(
      CupertinoAlertDialog(
        title: Text('You have not enabled read and write permissions for the album'.tr),
        content: Text('Do you want to go to settings to open?'.tr),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'.tr),
            textStyle: TextStyle(color: Colors.grey[600]),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            child: Text('Done'.tr),
            onPressed: () async {
              Get.back();
              await openAppSettings();
            },
          ),
        ],
      ),
      barrierDismissible: false);

  static Future<bool> contactsStatusIsGranted() async {
    return await Permission.contacts.isGranted;
  }

}
