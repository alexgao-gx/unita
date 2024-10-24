import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/api/log_api.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/food_model.dart';

import '../../models/log_model.dart';
import '../basic/app_bar.dart';
import '../basic/loading_button.dart';
import 'log_add_input_dialog.dart';
import 'log_food_item.dart';

class ScanMealPage<T extends ScanMealPageController>
    extends GetView<ScanMealPageController> {
  const ScanMealPage({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    Get.put(ScanMealPageController(file: file));
    return Scaffold(
      appBar: appBar(title: 'Scan Meal'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            40.verticalSpace,
            Obx(() => AspectRatio(
                  aspectRatio: controller.uploadFinished.value ? 16 / 9 : 1,
                  child: ImageWidget(
                      type: ImageWidgetType.file,
                      url: file.path,
                      fit: BoxFit.cover,
                      radius: 16.r),
                )),
            _buildFoodsView(),
          ],
        ).paddingHorizontal(14.w),
      ),
    );
  }

  Widget _buildFoodsView() => Obx(() {
        if (controller.uploadFinished.value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              34.verticalSpace,
              TextWidget(
                text: 'Foods & Ingredients To Log'.tr,
                size: 16.sp,
                weight: FontWeight.w500,
                color: AppColors.color_1A342B,
              ),
              20.verticalSpace,
              _buildScannedResult(controller.foodsRx.value),
              LoadingButton<T>(
                text: 'Save'.tr,
                onPressed: () {},
              )
            ],
          );
        } else {
          return _buildSteps();
        }
      });

  Widget _buildScannedResult(List<FoodModel> foods) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 42.h,
            child: index == foods.length
                ? OutlinedButton(
                    onPressed: () {
                      Get.dialog(LogAddInputDialog(onValueUpdated: (v) {
                        final appearance =
                            FoodModel(name: v, code: 'UNKNOWN', serving: 1);
                        controller.foodsRx.add(appearance);
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(40.h),
                        padding: EdgeInsets.zero,
                        shape: const StadiumBorder(),
                        side: const BorderSide(
                            color: AppColors.color_456C51, width: 0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidget.svg(
                          size: 16.w,
                          'assets/svg/ico_plus.svg',
                        ),
                        5.horizontalSpace,
                        TextWidget(
                          text: 'Add'.tr,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: AppColors.color_456C51),
                        )
                      ],
                    ))
                : LogFoodItemWidget(
                    title: foods[index].name ?? '',
                    numberValue: foods[index].serving?.toString() ?? '0',
                    onRemove: () {
                      controller.foodsRx.remove(foods[index]);
                    },
                    onSaved: (count) {
                      final sameFoods = controller.foodsRx
                          .where((e) => e.name == foods[index].name);
                      if (sameFoods.isNotEmpty) {
                        sameFoods.first.serving = count;
                        controller.foodsRx.value = controller.foodsRx
                            .map((e) => FoodModel.fromJson(e.toJson()))
                            .toList();
                        // controller.update(['FOODS_VIEW'], true);
                      }
                    },
                  ),
          );
        },
        separatorBuilder: (_, __) => 10.verticalSpace,
        itemCount: foods.length + 1,
      );

  Widget _buildSteps() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Step 1
        _buildStep(
          stepNumber: '01',
          stepTitle: 'Scan Your Meal'.tr,
          isLast: false,
        ),
        // Step 2
        _buildStep(
          stepNumber: '02',
          stepTitle: 'Edit Ingredients & Servings'.tr,
          isLast: false,
        ),
        // Step 3
        _buildStep(
          stepNumber: '03',
          stepTitle: 'Add Anything We Missed'.tr,
          isLast: false,
        ),
        // Step 4
        _buildStep(
          stepNumber: '04',
          stepTitle: 'Review & Log Your Meal!'.tr,
          isLast: true,
          showTada: true,
        ),
      ],
    ).paddingOnly(left: 75.w, top: 30.h);
  }

  Widget _buildStep({
    required String stepNumber,
    required String stepTitle,
    bool isLast = false,
    bool showTada = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left side: Step number, vertical line, and circle
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Step circle with number
            CircleAvatar(
              backgroundColor: AppColors.color_FFFCF5,
              radius: 5.r,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.color_65AF7C, width: 1),
                ),
              ),
            ),
            // Vertical line (if not the last item)
            Container(
              width: 1,
              height: 52.h,
              color: AppColors.color_65AF7C,
            ),
            if (isLast)
              Transform(
                transform: Matrix4.translationValues(0, -5, 0),
                child: const Icon(Icons.arrow_downward_rounded,
                    weight: 0.5, color: AppColors.color_65AF7C, size: 10),
              ),
          ],
        ),
        16.horizontalSpace, // Spacing between step number and text
        // Right side: Step description
        Expanded(
          child: Transform(
            transform: Matrix4.translationValues(0, -5, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Step number'.trArgs([stepNumber]),
                  style: GoogleFonts.openSans(
                      color: AppColors.color_65AF7C,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                TextWidget(
                  text: stepTitle,
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: AppColors.color_1A342B,
                ),
                if (showTada)
                  TextWidget(
                    text: '⭐ Ta-da ⭐'.tr,
                    size: 16.sp,
                    weight: FontWeight.w500,
                    color: AppColors.color_1A342B,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ScanMealPageController extends LoadingButtonController {
  final File file;

  RxList<FoodModel> foodsRx = <FoodModel>[].obs;
  RxBool uploadFinished = false.obs;

  ScanMealPageController({required this.file});

  @override
  void onInit() {
    _uploadFile();
    super.onInit();
  }

  Future<void> _uploadFile() async {
    Loading.show('Uploading...'.tr);
    try {
      foodsRx.value =
          await LogAPI.uploadMealFile(file, onSendProgress: (count, total) {
        // Loading.showProgress(count / total);
      });
      uploadFinished.value = true;
    } catch (e) {
      uploadFinished.value = true;
    }
    Loading.dismiss();
  }

  @override
  bool loadingButtonEnabled() {
    return true;
  }

  @override
  Future<bool> onLoadingButtonPressed() {
    final foodsInfo = foodsRx
        .map((e) => FoodInfo(
            foodName: e.name,
            foodCode: e.code ?? 'UNKNOW',
            foodServingSize: e.serving?.toString()))
        .toList();
    Get.back(result: foodsInfo);
    return Future.value(false);
  }
}
