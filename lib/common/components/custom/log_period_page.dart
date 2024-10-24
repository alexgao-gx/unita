import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/slider_text.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/text.dart';

import '../../api/auth_api.dart';
import '../../api/log_api.dart';
import '../../models/log_model.dart';
import '../../models/log_req_model.dart';
import '../../models/signup_flow_model.dart';
import '../basic/app_bar.dart';
import 'log_bm_appearances.dart';
import 'log_date_time.dart';

class LogPeriodPage extends GetView<LogPeriodPageController> {
  LogPeriodPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogPeriodPageController());
    return Scaffold(
      appBar: logAppBar(title: 'Period'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchPeriodLogInfo();
            }),
            TextWidget(
              text: 'Flow level'.tr,
              size: 16.sp,
              weight: FontWeight.w500,
              color: AppColors.color_1A342B,
            ).paddingHorizontal(14.w),
            25.verticalSpace,
            Obx(() => SliderTextWidget(
                  datas: controller.periodLevelRx.value,
                  onValueChanged: (v) {
                    controller.periodInfoRx.value.flowLevel =
                        int.tryParse(v.value ?? '1');
                  },
                )),
            36.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  datas: controller.periodDescRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.periodInfoRx.value.flowDescription =
                        v.value ?? v.text;
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class LogPeriodPageController extends GetxController {
  Rx<DateTime> dateRx = DateTime.now().obs;
  RxList<EnumModel> periodLevelRx = <EnumModel>[].obs;
  RxList<EnumModel> periodDescRx = <EnumModel>[].obs;
  Rx<PeriodInfo> periodInfoRx = PeriodInfo(flowLevel: 1).obs;

  @override
  void onInit() {
    fetchPeriodLogInfo();
    super.onInit();
  }

  Future<void> _fetchPeriodEnums() async {
    final resp =
        await AuthAPI.fetchSignupFlows(['PeriodLevelEnum', 'PeriodDescEnum']);
    if (periodLevelRx.isEmpty) {
      periodLevelRx.value = resp.periodLevelEnum ?? <EnumModel>[].obs;
    }
    if (periodDescRx.isEmpty) {
      periodDescRx.value = resp.periodDescEnum ?? <EnumModel>[].obs;
    }
  }

  Future<void> fetchPeriodLogInfo() async {
    await _fetchPeriodEnums();
    final logInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.PERIOD], logDate: dateRx.value);
    periodInfoRx.value = logInfo.periodInfo ?? PeriodInfo();

    // Flow Level
    periodLevelRx.value = periodLevelRx
        .map((e) => e
          ..isSelected.value =
              e.value == periodInfoRx.value.flowLevel?.toString())
        .toList();

    // Period Desc Flow
    final periodDescTypes = periodDescRx
        .where((e) => e.value == periodInfoRx.value.flowDescription);

    if (periodDescTypes.isEmpty && periodInfoRx.value.flowDescription != null) {
      periodDescRx.add(EnumModel(
          value: periodInfoRx.value.flowDescription,
          text: periodInfoRx.value.flowDescription));
    }
    periodDescRx.value = periodDescRx
        .map((e) =>
            e..isSelected.value = e.value == periodInfoRx.value.flowDescription)
        .toList();
  }

  Future<void> onSaveAll() async {
    await LogAPI.saveLogInfo(LogReqModel(
        periodInfo: periodInfoRx.value, logType: LogType.PERIOD.name));
    await fetchPeriodLogInfo();
    Get.back();
  }
}
