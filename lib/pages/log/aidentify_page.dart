import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/input_min_plus_number.dart';
import 'package:unitaapp/common/components/custom/scan_food_list_save.dart';
import 'package:unitaapp/common/index.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AIIdentifyPage extends StatelessWidget {
  AIIdentifyPage({super.key, required this.title});
  final String title;
  var isScanning = true.obs;
  List listFruit = [].obs;
  final Dio dio = Dio();
  var hasFile = false.obs;
  late String filePath;

  @override
  Widget build(BuildContext context) {
    takePhoto(context);
    // getLostData();
    // getImageByCamera(context);
    return Scaffold(
      appBar: appBar(title: title),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    width: 347.w,
                    height: 147.h,
                    child: ImageWidget(
                        fit: BoxFit.cover,
                        type: hasFile.value
                            ? ImageWidgetType.file
                            : ImageWidgetType.asset,
                        url: hasFile.value
                            ? filePath
                            : 'assets/images/identifydefault.png'),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  isScanning.value
                      ? scanningWidget()
                      : scanResultWidget(context),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  getImageByCamera(BuildContext context) async {
    //Future<File>
    try {
      final AssetEntity? result = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          shouldDeletePreviewFile: true,
          enableRecording: false,
          textDelegate: EnglishCameraPickerTextDelegate(),
        ),
      );
      if (result != null) {
        File? pickedFile = await result.file;
        // pickedFile = await compressFile(pickedFile);
        bool? exists = await pickedFile?.exists();
        print('exists===$exists,path==${pickedFile?.path}');
        filePath = pickedFile?.path ?? '';
        hasFile.value = true;
        uploadImage();
      } else {
        print('result == null');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {
      // _handleLostFiles(files);
    } else {
      // _handleError(response.exception);
    }
  }

  void takePhoto(context) async {
    // 添加延迟
    Future.delayed(const Duration(microseconds: 100), () async {
      // 在延迟后执行的代码
      getImageByCamera(context);

      // final AssetEntity? entity = await CameraPicker.pickFromCamera(
      //   context,
      //   pickerConfig: const CameraPickerConfig(),
      // );
      // if (entity != null) {
      //   debugPrint(entity.relativePath);
      // }
    });
  }

  showFoodListSaveSheet(context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ScanFoodListSave(
          height: 300,
          list: listFruit,
          onClose: () {
            Get.back();
          },
          onSave: () {
            Get.back();
            Get.back(result: listFruit);
          },
        );
      },
    );
  }

  Widget scanResultWidget(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Scanned Food',
          weight: FontWeight.w500,
          color: AppColors.color_1A342B,
          size: 16.sp,
        ),
        SizedBox(
          height: 19.h,
        ),
        GridView.builder(
          shrinkWrap: true, // 设置为true，使得GridView根据内容的高度进行收缩
          physics: const NeverScrollableScrollPhysics(), // 禁用GridView的滚动
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3.5,
          ),
          itemCount: listFruit.length,
          itemBuilder: (BuildContext context, int index) {
            String title = listFruit[index];
            return InputMinPlusNumber(
              title: title,
              height: 60,
            );
          },
        ),
        ButtonWidget.textIcon(
          width: 170.w,
          height: 40.h,
          'Add Ingredients',
          IconWidget.image('assets/images/ico_plus.png'),
          backgroundColor: AppColors.color_C1E1CE,
          borderRadius: 8.w,
          textColor: AppColors.color_1A342B,
          textSize: 12.sp,
          textWeight: FontWeight.w400,
        ).paddingTop(10.h),
        ButtonWidget.text(
          width: 229.w,
          height: 44.h,
          'Save',
          backgroundColor: AppColors.color_65AF7C,
          borderRadius: 8.w,
          textColor: AppColors.color_FCF8F1,
          textSize: 16.sp,
          textWeight: FontWeight.w600,
          onTap: () {
            print('save');
            showFoodListSaveSheet(context);
          },
        ).paddingTop(126.h).center(),
      ],
    )).paddingSymmetric(horizontal: 13.w);
  }

  Widget scanningWidget() {
    return Column(
      children: [
        TextWidget(
          text: 'AI Recognizing...',
          weight: FontWeight.w500,
          size: 16.sp,
          color: AppColors.color_1A342B,
        ),
        TextWidget(
          text: 'The process might take 1 or 2 minutes, please be patient.',
          weight: FontWeight.w500,
          size: 16.sp,
          color: AppColors.color_1A342B,
          maxLines: null,
          softWrap: true,
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 74.w, vertical: 7.h),
      ],
    );
  }

  Future<void> uploadImage() async {
    Loading.show('Uploading');
    // String filePath =
    //     '/private/var/mobile/Containers/Data/Application/6C1D1C24-7A3B-4603-AF14-76A4432F5051/tmp/flutter-images/6f81dea77ca6c2286fff8d5a718dd534_exif.jpg';
    String fileName = path.basename(filePath);
    print('File name: $fileName');
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });
      Response response = await dio.post(
        'https://www.quiznow.ai/ingredients',
        data: formData,
      );
      print(response.data);
      listFruit.addAll(response.data['ingredients']);
      isScanning.value = false;
      Loading.dismiss();
    } catch (error) {
      Loading.dismiss();
      print(error.toString());
    }
  }
}
