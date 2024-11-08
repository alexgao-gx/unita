import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/slider_text.dart';
import 'package:unitaapp/common/components/custom/log_bm_appearances.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/log_model.dart';

import '../../../pages/home/home_page.dart';
import '../../api/auth_api.dart';
import '../../api/log_api.dart';
import '../../models/log_req_model.dart';
import '../../models/signup_flow_model.dart';
import '../../services/user_service.dart';
import '../basic/app_bar.dart';
import 'log_date_time.dart';
import '../../utils/hive_box.dart';

class LogSymptomsPage extends GetView<LogSymptomsPageController> {
  const LogSymptomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogSymptomsPageController());
    return Scaffold(
      appBar: logAppBar(title: 'Symptoms'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchSymptomsLogInfo();
            }),
            _buildTummyPainPanel(),
            _buildPainLocationPanel(),
            _buildPainSymptoms(),
            _buildBloatedFeelPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildTummyPainPanel() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          border: Border(
              bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
            text: 'How much tummy pain do you feel'.tr,
            size: 16.sp,
            weight: FontWeight.w500,
            color: AppColors.color_1A342B,
          ).paddingHorizontal(14.w),
          30.verticalSpace,
          Obx(() => SliderTextWidget(
                datas: controller.painSeverityRx.value,
                onValueChanged: (v) {
                  controller.symptomsRx.value.tummyPainServerity =
                      int.tryParse(v.value ?? '1');
                },
              )),
          46.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildPainLocationPanel() {
    return Column(
      children: [
        51.verticalSpace,
        TextWidget(
          text: 'Indicate the areas where you felt your belly pain'.tr,
          size: 16.sp,
          weight: FontWeight.w500,
          color: AppColors.color_1A342B,
          softWrap: true,
          maxLines: null,
        ),
        35.verticalSpace,
        Stack(
          children: [
            Positioned(
              left: 80, // 将Text放置在左侧
              top: 0,
              bottom: 0, // 垂直居中的位置
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  text: 'R'.tr,
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: AppColors.color_1A342B,
                ),
              ),
            ),
            Positioned(
              right: 80, // 将Text放置在左侧
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextWidget(
                  text: 'L'.tr,
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: AppColors.color_1A342B,
                ),
              ),
            ),
            GetBuilder(
                id: 'SYMPTOMS_LOCATION',
                builder: (LogSymptomsPageController controller) =>
                    IconWidget.svg(
                      'assets/svg/img_locate_${controller.symptomsRx.value.tummyPainLocations ?? '0'}.svg',
                      width: 232.w,
                      height: 230.h,
                    )).center(),
            Positioned(
              bottom: 38,
              left: 0,
              right: 0,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行6个图标
                  mainAxisSpacing: 1, // 主轴间距，垂直
                  crossAxisSpacing: 1, // 水平轴间距
                  childAspectRatio: 1.5,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.symptomsRx.value.tummyPainLocations ==
                          '${index + 1}') {
                        controller.symptomsRx.value.tummyPainLocations = '0';
                      } else {
                        controller.symptomsRx.value.tummyPainLocations =
                            '${index + 1}';
                      }

                      controller.update(['SYMPTOMS_LOCATION']);
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  );
                },
              ).paddingOnly(left: 110.w, right: 110.w),
            ),
          ],
        ),
        21.verticalSpace,
        TextWidget(
          text: 'Tap to locate your pain'.tr,
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.color_1A342B,
          ),
        ).center(),
        36.verticalSpace,
      ],
    ).paddingHorizontal(14.w);
  }

  Widget _buildPainSymptoms() {
    return Container(
      padding: EdgeInsets.only(bottom: 50.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          border: const Border(
              bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
      child: Obx(() => LogBmAppearancesWidget(
            datas: controller.painSymptomsRx.value,
            onBmAppearanceChanged: (v) {
              controller.symptomsRx.value.tummyPainTypes = v.value ?? v.text;
            },
          )),
    );
  }

  Widget _buildBloatedFeelPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        44.verticalSpace,
        TextWidget(
          text: 'How bloated do you feel'.tr,
          size: 16.sp,
          weight: FontWeight.w500,
          color: AppColors.color_1A342B,
        ).paddingHorizontal(14.w),
        30.verticalSpace,
        Obx(() => SliderTextWidget(
              datas: controller.bloatedSeverityRx.value,
              onValueChanged: (v) {
                controller.symptomsRx.value.bloatedServerity =
                    int.tryParse(v.value ?? '1');
              },
            )),
        36.verticalSpace,
        Obx(() => LogBmAppearancesWidget(
              showAdd: false,
              datas: controller.bloatedSymptomsRx.value,
              onBmAppearanceChanged: (v) {
                controller.symptomsRx.value.bloatedSymptoms = v.value;
              },
            )),
        31.verticalSpace,
      ],
    );
  }
}

class LogSymptomsPageController extends GetxController {
  Rx<DateTime> dateRx = DateTime.now().obs;

  RxList<EnumModel> painSeverityRx = <EnumModel>[].obs;
  RxList<EnumModel> painSymptomsRx = <EnumModel>[].obs;
  RxList<EnumModel> bloatedSeverityRx = <EnumModel>[].obs;
  RxList<EnumModel> bloatedSymptomsRx = <EnumModel>[].obs;
  Rx<SymptomsInfo> symptomsRx = SymptomsInfo(tummyPainLocations: '0').obs;

  @override
  void onInit() {
    fetchSymptomsLogInfo();
    super.onInit();
  }

  Future<void> _fetchPainDegrees() async {
    final resp = await AuthAPI.fetchSignupFlows(
        ['ServerityEnum', 'PainSymptomsEnum', 'BloatedSymptomsEnum']);
    if (painSeverityRx.isEmpty) {
      painSeverityRx.value = (resp.serverityEnum ?? <EnumModel>[])
          .map((e) => EnumModel.fromJson(e.toJson()))
          .toList()
          .obs;
    }
    if (painSymptomsRx.isEmpty) {
      painSymptomsRx.value = resp.painSymptomsEnum ?? <EnumModel>[].obs;
    }
    if (bloatedSeverityRx.isEmpty) {
      bloatedSeverityRx.value = (resp.serverityEnum ?? <EnumModel>[])
          .map((e) => EnumModel.fromJson(e.toJson()))
          .toList()
          .obs;
    }
    if (bloatedSymptomsRx.isEmpty) {
      bloatedSymptomsRx.value = resp.bloatedSymptomsEnum ?? <EnumModel>[].obs;
    }
  }

  Future<void> fetchSymptomsLogInfo() async {
    await _fetchPainDegrees();
    final logInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.SYMPTOMS], logDate: dateRx.value);
    symptomsRx.value = logInfo.symptomsInfo ?? SymptomsInfo();

    // Pain Severity
    painSeverityRx.value = painSeverityRx.map((e) {
      if (symptomsRx.value.tummyPainServerity != null) {
        e.isSelected.value =
            e.value == symptomsRx.value.tummyPainServerity.toString();
      }
      return e;
    }).toList();

    // Pain Symptoms
    final painTypes = painSymptomsRx
        .where((e) => e.value == logInfo.symptomsInfo?.tummyPainTypes);

    if (painTypes.isEmpty && logInfo.symptomsInfo?.tummyPainTypes != null) {
      painSymptomsRx.add(EnumModel(
          value: logInfo.symptomsInfo?.tummyPainTypes,
          text: logInfo.symptomsInfo?.tummyPainTypes));
    }
    painSymptomsRx.value = painSymptomsRx
        .map((e) => e
          ..isSelected.value = e.value == logInfo.symptomsInfo?.tummyPainTypes)
        .toList();

    // Bloated Severity
    bloatedSeverityRx.value = bloatedSeverityRx.map((e) {
      if (symptomsRx.value.bloatedServerity != null) {
        e.isSelected.value =
            e.value == symptomsRx.value.bloatedServerity.toString();
      }
      return e;
    }).toList();

    // Bloated Symptoms
    final bloatedTypes = bloatedSymptomsRx
        .where((e) => e.value == logInfo.symptomsInfo?.bloatedSymptoms);

    if (bloatedTypes.isEmpty && logInfo.symptomsInfo?.bloatedSymptoms != null) {
      bloatedSymptomsRx.add(EnumModel(
          value: logInfo.symptomsInfo?.bloatedSymptoms,
          text: logInfo.symptomsInfo?.bloatedSymptoms));
    }
    bloatedSymptomsRx.value = bloatedSymptomsRx
        .map((e) => e
          ..isSelected.value = e.value == logInfo.symptomsInfo?.bloatedSymptoms)
        .toList();

    update(['SYMPTOMS_LOCATION']);
  }

  Future<void> onSaveAll({bool navigateBack = true}) async {
    String userId = HiveBox.user.getUser().id.toString();
    await LogAPI.saveLogInfo(LogReqModel(
        symptomsInfo: symptomsRx.value,
        logType: LogType.SYMPTOMS.name,
        userId: userId));

    await fetchSymptomsLogInfo();
    if (Get.isRegistered<HomePageController>()) {
      Get.find<HomePageController>().fetchHomeLogInfo();
      Get.find<UserService>().fetchUserInfo();
    }
    if (navigateBack) {
      Get.back();
    }
  }
}
