import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/api/plan_api.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/custom/plan_activity.dart';
import 'package:unitaapp/common/components/custom/plan_record_tile.dart';
import 'package:unitaapp/common/index.dart';

import '../../common/components/custom/history_log_days.dart';
import '../../common/components/custom/plan_dietary.dart';
import '../../common/models/plan_model.dart';

class PlanPage extends GetView<PlanPageController> {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlanPageController());
    return Scaffold(
      appBar: appBar(title: 'Plan'.tr, showLeading: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHistoryPlay(),
            PlanRecordTile(
              svgPath: 'assets/svg/ico_mind&body.svg',
              tileName: 'Daily Activities'.tr,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => PlanActivityWidget(
                        svgPath: 'assets/svg/mindplan.svg',
                        title: 'Mind'.tr,
                        newFlag:
                            controller.planRx.value.mindInfo?.newFlag ?? false,
                        subTitle:
                            'Complete 3 days of program to unlock new program'
                                .tr,
                        currTimes: controller.planRx.value.mindInfo?.currTimes,
                        perTimes: controller.planRx.value.mindInfo?.perTimes,
                        onTap: () async {
                          await Get.toNamed(RouteNames.mind);
                          controller.fetchPlanInfo();
                        },
                      )),
                  8.verticalSpace,
                  Obx(() => PlanActivityWidget(
                        svgPath: 'assets/svg/bodyplan.svg',
                        title: 'Body'.tr,
                        newFlag:
                            controller.planRx.value.bodyInfo?.newFlag ?? false,
                        currTimes: controller.planRx.value.bodyInfo?.currTimes,
                        perTimes: controller.planRx.value.bodyInfo?.perTimes,
                        onTap: () async {
                          await Get.toNamed(RouteNames.body);
                          controller.fetchPlanInfo();
                        },
                      )),
                ],
              ),
            ),
            PlanRecordTile(
              svgPath: 'assets/svg/ico_Report.svg',
              tileName: 'Dietary Education'.tr,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => PlanDietaryWidget(
                        svgPath: 'assets/svg/dietplan.svg',
                        title: 'Diet'.tr,
                        newFlag: controller.planRx.value.dietFlag ?? false,
                        subTitle: 'Recommended / Avoid Food'.tr,
                        onTap: () {
                          Get.toNamed(RouteNames.diet);
                        },
                      )),
                  8.verticalSpace,
                  Obx(() => PlanDietaryWidget(
                        svgPath: 'assets/svg/herbplan.svg',
                        title: 'Herb'.tr,
                        newFlag: controller.planRx.value.herbFlag ?? false,
                        subTitle: 'Herbal Tea / Chinese Patent Medicine'.tr,
                        onTap: () {
                          Get.toNamed(RouteNames.herb);
                        },
                      ))
                ],
              ),
            ),
            48.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryPlay() => Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
            border: Border(
                bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            27.verticalSpace,
            Obx(() => TextWidget(
                text: 'Day 8 / 21'.trArgs([
                  '${controller.planRx.value.currTimes ?? 0}',
                  '${controller.planRx.value.perTimes ?? 3}'
                ]),
                size: 26.sp,
                color: AppColors.color_1A342B,
                weight: FontWeight.w600)),
            10.verticalSpace,
            TextWidget(
              text:
                  'Lorem ipsum dolor sit ame, consectetur adipiscin elit, sed do eiusmod tempor.'
                      .tr,
              maxLines: null,
              softWrap: true,
              style: GoogleFonts.openSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color_A7998F),
            ),
            27.verticalSpace,
            Obx(() =>
                HistoryLogDays(dayLogs: controller.planRx.value.historyInfo)),
            44.verticalSpace,
          ],
        ),
      );
}

class PlanPageController extends GetxController {
  Rx<PlanModel> planRx = PlanModel().obs;

  @override
  void onInit() {
    fetchPlanInfo();
    super.onInit();
  }

  Future<void> fetchPlanInfo() async {
    planRx.value = await PlanAPI.fetchPlanInfo();
  }
}
