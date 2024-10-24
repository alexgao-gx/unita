import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/custom/log_bm_shape.dart';
import 'package:unitaapp/common/components/custom/log_bowelmovement_page.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/log_model.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

import '../../api/log_api.dart';
import '../../models/log_req_model.dart';
import '../../style/colors.dart';
import '../../widgets/text.dart';
import 'log_bm_appearances.dart';

class LogBmHistoryEdit extends GetView<LogBmHistoryEditController> {
  const LogBmHistoryEdit({super.key, required this.history});
  final BowelMovementInfo history;

  @override
  String? get tag => history.id.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(LogBmHistoryEditController(history: history),
        tag: history.id.toString());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                top: 12.h,
                child: TextWidget(
                  text: 'Poop History | log time'.trArgs([(history.logTime ?? '')]),
                  size: 18.sp,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w700,
                  color: AppColors.color_1A342B,
                ),
              ),
              Row(
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.only(
                          left: 0, top: 15.h, bottom: 15.h, right: 20.w),
                      child: TextWidget(
                        color: AppColors.color_C5C5C5,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        text: 'Cancel'.tr,
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.5,
            color: AppColors.color_E6DCD6,
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          40.verticalSpace,
          LogBmShapeWidget(
            shapeIcons: Get.find<LogBowelMovementPageController>().bmShapeIcons,
            shapes: controller.shapes,
            onShapeChanged: (EnumModel shape, int shapeIndex) {
              controller.bmReqModel.shape = int.tryParse(shape.value ?? '1');
            },
          ),
          40.verticalSpace,
          LogBmAppearancesWidget(
            datas: controller.appearances,
            onBmAppearanceChanged: (v) {
              controller.bmReqModel.apperance = v.value ?? v.text;
            },
          ),
          58.verticalSpace,
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(
                            side: BorderSide(
                                color: AppColors.color_1A342B, width: 0.5)),
                      ),
                      child: TextWidget(
                        text: 'Remove'.tr,
                        weight: FontWeight.w600,
                        color: AppColors.color_1A342B,
                        size: 16.sp,
                      ),
                      onPressed: () async {
                        await controller.onRemove();
                        Get.back();
                      },
                    ),
                  )),
              8.horizontalSpace,
              Expanded(
                  flex: 4,
                  child: ContainerTextButton(
                    tapAction: () async {
                      await controller.onSave();
                      Get.back();
                    },
                    bgColor: AppColors.color_65AF7C,
                    borderRadius: 44.h,
                    height: 44,
                    text: 'Save'.tr,
                    textWeight: FontWeight.w600,
                    textColor: AppColors.color_FCF8F1,
                    textSize: 16.sp,
                    width: double.infinity,
                  )),
            ],
          )
        ],
      ),
    ));
  }
}

class LogBmHistoryEditController extends GetxController {
  final BowelMovementInfo history;

  LogBowelMovementPageController bmController =
      Get.find<LogBowelMovementPageController>();

  LogBmHistoryEditController({required this.history});
  late BowelMovementInfo bmReqModel;

  List<EnumModel> get shapes => Get.find<LogBowelMovementPageController>()
      .bmShapesRx
      .map((e) => e..isSelected.value = e.value == history.shape?.toString())
      .toList();

  List<EnumModel> get appearances {
    final appearancesEnum = List<EnumModel>.from(
        Get.find<LogBowelMovementPageController>().bmAppearancesRx);
    final appearances =
        appearancesEnum.where((e) => e.value == history.apperance);

    if (appearances.isEmpty && history.apperance != null) {
      appearancesEnum
          .add(EnumModel(value: history.apperance, text: history.apperance));
    }
    return appearancesEnum
        .map((e) =>
            e..isSelected.value = e.value == history.apperance?.toString())
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    bmReqModel = BowelMovementInfo.fromJson(history.toJson());
  }

  Future<void> onSave() async {
    await LogAPI.saveLogInfo(LogReqModel(
        bowelMovementInfo: bmReqModel, logType: LogType.BOWEL_MOVEMENT.name));
    await bmController.fetchBMLogInfo();
  }

  Future<void> onRemove() async {
    await LogAPI.removeBowelMovementLogInfo(logId: bmReqModel.id ?? -1);
    await bmController.fetchBMLogInfo();
  }
}
