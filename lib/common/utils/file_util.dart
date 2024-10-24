import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unitaapp/common/index.dart';

import 'loading.dart';

//全局key-截图key
final GlobalKey boundaryKey = GlobalKey();

class FileUtil {
//生成截图
  /// 截屏图片生成图片流ByteData
  static Future<String> captureImage() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    var filePath = "";

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // getApplicationDocumentsDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
            applicationDir.path + "${DateTime.now().toIso8601String()}.jpg")
        .writeAsBytes(pngBytes);
    filePath = saveFile.path;
    // if (Platform.isAndroid) {
    //   // 如果是Android 的话，直接使用image_gallery_saver就可以了
    //   // 图片byte数据转化unit8
    //   Uint8List images = byteData!.buffer.asUint8List();
    //   // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
    //   String result = await ImageGallerySaver.saveImage(images);
    //   // 需要去除掉file://开头。生成要使用的file
    //   File saveFile = new File(result.replaceAll("file://", ""));
    //   filePath = saveFile.path;
    //
    //
    // } else if (Platform.isIOS) {
    //   // 图片byte数据转化unit8
    //
    // }

    return filePath;
  }

//申请存本地相册权限
  static Future<bool> getPormiation() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
        ].request();
        // saveImage(globalKey);
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

//保存到相册
  static void savePhoto() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage();
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //获取保存相册权限，如果没有，则申请改权限
    bool permition = await getPormiation();

    if (permition) {
      if (Platform.isIOS) {
        var status = await Permission.photos.status;

        if (status.isGranted) {
          Uint8List images = byteData!.buffer.asUint8List();
          await ImageGallerySaver.saveImage(images,
              quality: 60, name: 'share_payment');
          Loading.toast('Save Success'.tr);
        }
        if (status.isDenied) {
          Loading.toast('Save failed, please authorize the album permissions'.tr);
        }
      } else {
        //安卓
        var status = await Permission.storage.status;
        if (status.isGranted) {
          Uint8List images = byteData!.buffer.asUint8List();
          final result = await ImageGallerySaver.saveImage(images, quality: 60);
          if (result != null) {
            Loading.toast('Save Success'.tr);
          } else {
            Loading.toast('Save failed, please try again'.tr);
          }
        }
      }
    } else {
      //重新请求--第一次请求权限时，保存方法不会走，需要重新调一次
      savePhoto();
    }
  }

  /// 直接从相册获取图片(不裁剪)
  static Future<File?> getGalleryImageDirectly() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return xFile == null ? null : File(xFile.path);
  }

  /// 直接从相机拍摄图片(不裁剪)
  static Future<File?> takeCameraPhotoDirectly() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    return xFile == null ? null : File(xFile.path);
  }

  /// 获取视频
  static Future<File?> getVideoFile() async {
    final xFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

    return xFile == null ? null : File(xFile.path);
  }

  /// 上传头像裁剪图片
  /// return 裁剪后的filePath
  static Future<File?> cropImageByUpdateAvatar(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio:const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Avatar'.tr,
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: AppColors.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Avatar'.tr,
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockDimensionSwapEnabled: false,
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: true,
        )
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  /// 收款二维码/银卡照片
  /// return 裁剪后的filePath
  static Future<File?> cropImageByPayment(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      maxWidth: 300,
      maxHeight: 300,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop photo'.tr,
            toolbarColor: Get.theme.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop photo'.tr,
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          // aspectRatioLockEnabled: true,
          // aspectRatioPickerButtonHidden: true,
          // aspectRatioLockDimensionSwapEnabled: false,
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: true,
        )
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  /// 裁剪图片
  /// return 裁剪后的filePath
  static Future<File?> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop photo'.tr,
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop photo'.tr,
          doneButtonTitle: 'Done'.tr,
          cancelButtonTitle: 'Cancel'.tr,
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockDimensionSwapEnabled: false,
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: true,
        )
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  /// 将图片按照指定大小(单位byte)进行压缩
  static Future<File> compressImageToBytes(File originFile,
      {int maxBytes = 500 * 1000}) async {
    final originBytes = await originFile.length();

    File compressedFile = originFile;
    if (originBytes < maxBytes) return originFile;
    int beginTimestamp = DateTime.now().millisecondsSinceEpoch;
    double compression = 100;
    double max = 100;
    double min = 0;
    // 这里经过6次二分法压缩，最小压缩比例会达到0.015左右,已经很小了，足够趋向目标大小
    for (int i = 0; i < 6; ++i) {
      compression = (max + min) / 2;
      compressedFile = await FlutterNativeImage.compressImage(originFile.path,
          percentage: compression.ceil());
      final compressedBytes = await compressedFile.length();
      if (compressedBytes < maxBytes * 0.9) {
        min = compression;
      } else if (compressedBytes > maxBytes) {
        max = compression;
      } else {
        break;
      }
    }

    if (compressedFile.lengthSync() < maxBytes) return compressedFile;
    int lastCompressedBytes = 0;
    int compressedBytes = await compressedFile.length();
    while (
        compressedBytes > maxBytes && compressedBytes != lastCompressedBytes) {
      lastCompressedBytes = compressedBytes;
      double ratio = maxBytes / compressedBytes;
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(compressedFile.path);
      int targetW = (properties.width! * sqrt(ratio)).ceil();
      int targetH = (properties.height! * sqrt(ratio)).ceil();

      compressedFile = await FlutterNativeImage.compressImage(
          compressedFile.path,
          targetWidth: targetW,
          targetHeight: targetH);
      compressedBytes = await compressedFile.length();
    }

    return compressedFile;
  }

  /// 将图片按照指定百分比/质量/目标宽/目标高进行压缩
  static Future<File> compressImage(File originFile,
      {int percentage = 70,
      int quality = 70,
      int targetWidth = 0,
      int targetHeight = 0}) async {
    return await FlutterNativeImage.compressImage(originFile.path,
        percentage: percentage,
        quality: quality,
        targetWidth: targetWidth,
        targetHeight: targetHeight);
  }
}
