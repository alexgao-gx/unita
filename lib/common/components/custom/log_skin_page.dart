import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/slider_text.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/log_model.dart';
import 'package:unitaapp/common/models/log_req_model.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/text.dart';

import '../../api/auth_api.dart';
import '../../api/log_api.dart';
import '../../models/signup_flow_model.dart';
import '../basic/app_bar.dart';
import 'log_bm_appearances.dart';
import 'log_date_time.dart';

class LogSkinPage extends GetView<LogSkinPageController> {
  LogSkinPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogSkinPageController());
    return Scaffold(
      appBar: logAppBar(title: 'Skin'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchSkinLogInfo();
            }),
            TextWidget(
              text: 'What is the condition of your skin?'.tr,
              size: 16.sp,
              weight: FontWeight.w500,
              color: AppColors.color_1A342B,
            ).paddingSymmetric(horizontal: 14.w),
            SizedBox(
              height: 30.h,
            ),
            Obx(() => SliderTextWidget(
                  datas: controller.skinLevelRx.value,
                  onValueChanged: (v) {
                    controller.skinInfoRx.value.conditions =
                        int.tryParse(v.value ?? '1');
                  },
                )),
            36.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  crossAxisCount: 3,
                  childAspectRatio: 2.8,
                  datas: controller.skinDescRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.skinInfoRx.value.description = v.value ?? v.text;
                  },
                )),
            54.verticalSpace,
            TextWidget(
              text: 'Location of Skin Problem'.tr,
              size: 16.sp,
              weight: FontWeight.w500,
              color: AppColors.color_1A342B,
            ).paddingHorizontal(14.w),
            25.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  crossAxisCount: 3,
                  childAspectRatio: 2.8,
                  datas: controller.skinLocationRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.skinInfoRx.value.location = v.value ?? v.text;
                  },
                )),
            68.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class LogSkinPageController extends GetxController {
  Rx<DateTime> dateRx = DateTime.now().obs;
  RxList<EnumModel> skinLevelRx = <EnumModel>[].obs;
  RxList<EnumModel> skinDescRx = <EnumModel>[].obs;
  RxList<EnumModel> skinLocationRx = <EnumModel>[].obs;
  Rx<SkinInfo> skinInfoRx = SkinInfo().obs;

  @override
  void onInit() {
    fetchSkinLogInfo();
    super.onInit();
  }

  Future<void> _fetchSkinEnums() async {
    final resp = await AuthAPI.fetchSignupFlows(
        ['SkinLevelEnum', 'SkinDescEnum', 'SkinLocationEnum']);
    if (skinLevelRx.isEmpty) {
      skinLevelRx.value = resp.skinLevelEnum ?? <EnumModel>[].obs;
    }
    if (skinDescRx.isEmpty) {
      skinDescRx.value = resp.skinDescEnum ?? <EnumModel>[].obs;
    }
    if (skinLocationRx.isEmpty) {
      skinLocationRx.value = resp.skinLocationEnum ?? <EnumModel>[].obs;
    }
  }

  Future<void> fetchSkinLogInfo() async {
    await _fetchSkinEnums();
    final skinInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.SKIN], logDate: dateRx.value);
    skinInfoRx.value = skinInfo.skinInfo ?? SkinInfo();
    skinLevelRx.value = skinLevelRx
        .map((e) => e
          ..isSelected.value =
              e.value == (skinInfoRx.value.conditions ?? 0).toString() &&
                  e.value != null)
        .toList();
// skinDescRx
    final skinDescTypes =
        skinDescRx.where((e) => e.value == skinInfoRx.value.description);

    if (skinDescTypes.isEmpty && skinInfoRx.value.description != null) {
      skinDescRx.add(EnumModel(
          value: skinInfoRx.value.description,
          text: skinInfoRx.value.description));
    }
    skinDescRx.value = skinDescRx
        .map((e) =>
            e..isSelected.value = e.value == skinInfoRx.value.description)
        .toList();
// skinLocationRx
    final skinLocationTypes =
        skinLocationRx.where((e) => e.value == skinInfoRx.value.location);

    if (skinLocationTypes.isEmpty && skinInfoRx.value.location != null) {
      skinLocationRx.add(EnumModel(
          value: skinInfoRx.value.location, text: skinInfoRx.value.location));
    }
    skinLocationRx.value = skinLocationRx
        .map((e) => e..isSelected.value = e.value == skinInfoRx.value.location)
        .toList();
  }

  Future<void> onSaveAll({bool navigateBack = true}) async {
    await LogAPI.saveLogInfo(
        LogReqModel(skinInfo: skinInfoRx.value, logType: LogType.SKIN.name));
    await fetchSkinLogInfo();
    if (navigateBack) {
      Get.back();
    }
  }
}
