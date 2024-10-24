import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/container_icon.dart';
import 'package:unitaapp/common/components/basic/container_icon_text_arrow.dart';
import 'package:unitaapp/common/components/basic/search_input.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/log_model.dart';

import '../../models/food_model.dart';
import '../../style/colors.dart';
import '../../utils/file_util.dart';
import '../../utils/permissions_util.dart';
import '../../utils/widget_util.dart';
import 'log_beverage_item.dart';
import 'log_food_counter.dart';
import 'log_food_item.dart';
import 'log_food_page.dart';

class LogFoodTabView<T extends LogFoodPageController>
    extends GetView<LogFoodPageController> {
  const LogFoodTabView({
    super.key,
    this.onValueChanged,
    required this.foods,
    this.onRemoveFood,
    this.onFoodCountUpdated,
  });
  final ValueChanged<FoodModel?>? onValueChanged;
  final List<FoodInfo> foods;
  final ValueChanged<FoodInfo>? onRemoveFood;
  final Function(FoodInfo food, int count)? onFoodCountUpdated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
      decoration: FoodTabViewDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ContainerIcon(
                width: 51.w,
                height: 51.w,
                radius: 14.r,
                color: AppColors.color_E0EFE1,
                image: 'ico_AIidentify',
                iconSize: 30.h,
                onPressed: () async {
                  WidgetUtil.showUploadImageOperations(context, () async {
                    if (await PermissionsUtil.requestCameraPermission()) {
                      final file = await takePhotos(isFromGallery: false);
                      if (file != null) {
                        final result = await Get.toNamed(RouteNames.scanMeal,
                            arguments: file);
                        if (result is List<FoodInfo> && result.isNotEmpty) {
                          // foods.addAll(result);
                          final temp = mergeFoodLists(foods, result);
                          foods.clear();
                          foods.addAll(temp);
                        }
                      }
                    }
                  }, () async {
                    if (await PermissionsUtil.requestStoragePermission()) {
                      final file = await takePhotos(isFromGallery: true);
                      if (file != null) {
                        final result = await Get.toNamed(RouteNames.scanMeal,
                            arguments: file);
                        if (result is List<FoodInfo> && result.isNotEmpty) {
                          // foods.addAll(result);
                          final temp = mergeFoodLists(foods, result);
                          foods.clear();
                          foods.addAll(temp);
                        }
                      }
                    }
                  });
                },
              ),
              10.horizontalSpace,
              Expanded(child: SearchInputWidget<T>(
                onValueChanged: (food) {
                  onValueChanged?.call(food);
                },
              )),
            ],
          ),
          5.verticalSpace,
          TextWidget(
            text: '*The food unit is serving size'.tr,
            style: GoogleFonts.openSans(
                color: AppColors.color_456C51,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          // _buildFoodGridView(),
          _buildFoodsView(),
        ],
      ),
    );
  }

  Widget _buildEmptyView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          29.verticalSpace,
          TextWidget(
              text: '☝️',
              size: 24.sp,
              weight: FontWeight.w500,
              textAlign: TextAlign.center),
          TextWidget(
            text:
                'Find the food you ate or snap \na photo to identify and log it.'.tr,
            size: 16.sp,
            weight: FontWeight.w500,
            color: AppColors.color_A7998F,
            softWrap: true,
            maxLines: null,
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _buildFoodsView() => Obx(() => foods.isNotEmpty
      ? ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = foods[index];
            final title = item.foodName ?? '';
            final count = item.foodServingSize ?? '0';
            return SizedBox(
              height: 42.h,
              child: LogFoodItemWidget(
                title: title,
                numberValue: count,
                onRemove: () {
                  onRemoveFood?.call(foods[index]);
                },
                onSaved: (count) {
                  onFoodCountUpdated?.call(foods[index], count);
                },
              ),
            );
          },
          separatorBuilder: (_, __) => 10.verticalSpace,
          itemCount: foods.length,
        )
      : _buildEmptyView());

  Widget _buildFoodGridView() => Obx(() => foods.isNotEmpty
      ? GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 25.h),
          shrinkWrap: true, // 设置为true，使得GridView根据内容的高度进行收缩
          physics: const NeverScrollableScrollPhysics(), // 禁用GridView的滚动
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 4,
          ),
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            return LogFoodItemWidget(
              title: foods[index].foodName ?? '',
              numberValue: foods[index].foodServingSize ?? '',
              onRemove: () {
                onRemoveFood?.call(foods[index]);
              },
              onSaved: (count) {
                onFoodCountUpdated?.call(foods[index], count);
              },
            );
          },
        )
      : _buildEmptyView());

  /// isFromGallery 是否从相册选择图片
  Future takePhotos({bool isFromGallery = true}) async {
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
      final compressedFile =
          await FileUtil.compressImageToBytes(pickFile, maxBytes: 500 * 1000);
      return compressedFile;
    }
  }

  // 方法来合并两个 List<Model>
  List<FoodInfo> mergeFoodLists(List<FoodInfo> list1, List<FoodInfo> list2) {
    Map<String, FoodInfo> foodMap = {};

    // 将 String? 转换为 int 的辅助函数
    int _parseServingSize(String? servingSize) {
      return servingSize != null ? int.tryParse(servingSize) ?? 0 : 0;
    }

    // 合并两个列表
    for (var item in [...list1, ...list2]) {
      if (item.foodName != null && foodMap.containsKey(item.foodName)) {
        // 累加 servingSize
        var currentServingSize = _parseServingSize(foodMap[item.foodName]!.foodServingSize);
        var newServingSize = _parseServingSize(item.foodServingSize);

        // 更新 servingSize
        foodMap[item.foodName]!.foodServingSize = (currentServingSize + newServingSize).toString();
      } else if (item.foodName != null) {
        // 如果不存在，添加新的 FoodModel
        foodMap[item.foodName!] = FoodInfo(
          foodCode: item.foodCode,
          foodEngName: item.foodEngName,
          foodName: item.foodName,
          foodServingSize: item.foodServingSize,
          logDate: item.logDate,
          logTime: item.logTime,
        );
      }
    }

    return foodMap.values.toList();
  }
}

class FoodTabViewDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FoodTabViewDecorationPainter(this, onChanged);
  }
}

class _FoodTabViewDecorationPainter extends BoxPainter {
  final FoodTabViewDecoration decoration;
  _FoodTabViewDecorationPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint borderPaint = Paint()
      ..color = AppColors.color_A7998F // 边框颜色
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final Rect rect = offset & configuration.size!;
    final double curveHeight = 40.r;
    final Path path = Path();

    // 左侧起点
    path.moveTo(0, rect.bottom - curveHeight);
    // 第一个圆弧
    path.quadraticBezierTo(0, rect.bottom, curveHeight, rect.bottom);
    // 第二个圆弧
    path.lineTo(rect.right - curveHeight, rect.bottom);
    path.quadraticBezierTo(
        rect.right, rect.bottom, rect.right, rect.bottom - curveHeight);

    canvas.drawPath(path, borderPaint);
  }
}
