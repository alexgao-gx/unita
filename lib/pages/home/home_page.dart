import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/api/home_api.dart';
import 'package:unitaapp/common/components/basic/devider_image_text.dart';
import 'package:unitaapp/common/components/basic/icon_title_content_arrow.dart';
import 'package:unitaapp/common/components/basic/plan_image_text_progress.dart';
import 'package:unitaapp/common/components/custom/todays_log.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/home_log_info.dart';
import 'package:unitaapp/common/models/home_tips_model.dart';
import 'package:unitaapp/common/services/auth_service.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/pages/log/log_page.dart';
import 'package:unitaapp/pages/plan/assessment_detai_page.dart';

import '../../common/components/custom/history_log_days.dart';

class HomePage extends GetView<HomePageController> {
  // HomePage(List list, {super.key});

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color_FFFCF5,
        centerTitle: true,
        title: ImageWidget.asset(
          'assets/images/Unita.png',
          width: 95.w,
          height: 28.h,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 55.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 140.w,
                    height: 150.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/homescorebg.png')),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(() => SizedBox(
                              width: 140.w,
                              child: TextWidget(
                                text: controller.username,
                                weight: FontWeight.w600,
                                color: AppColors.color_1A342B,
                                size: 30.sp,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            )),
                        CupertinoButton(
                            minSize: 30,
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: 'Reports'.tr,
                                  weight: FontWeight.w400,
                                  color: AppColors.color_1A342B,
                                  size: 11.sp,
                                  textAlign: TextAlign.center,
                                ),
                                5.horizontalSpace,
                                Transform(
                                  transform: Matrix4.translationValues(0, 2, 0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                    color: AppColors.color_1A342B,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {})
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Center(
                  child: DividerImageText(
                    text: 'Daily Wisdom'.tr,
                    icon: IconWidget.svg(
                      'assets/svg/ico_daily_wisdom.svg',
                      size: 18,
                    ),
                    goDetail: () {},
                  ),
                ),
                34.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Obx(() => TextWidget(
                            text: controller.tipsRx.value.tips ??
                                'If there is flow, there is no pain'.tr,
                            weight: FontWeight.w500,
                            color: AppColors.color_1A342B,
                            size: 18.sp,
                            softWrap: true,
                            maxLines: null,
                            textAlign: TextAlign.center,
                          )),
                    ),
                    34.verticalSpace,
                    Obx(() => TextWidget(
                          text: '~ ${controller.tipsRx.value.source ?? ''}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.color_1A342B,
                            fontSize: 14,
                          ),
                        ))
                  ],
                ),
                25.verticalSpace,
                const Divider(
                  height: 1,
                  color: AppColors.color_E6DCD6,
                ),
                Obx(() => Column(
                      children: [
                        30.verticalSpace,
                        HistoryLogDays(
                            dayLogs: controller.logInfoRx.value.historyInfo),
                        23.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: 'Day 8 / 21'.trArgs([
                                  '${controller.logInfoRx.value.currTimes ?? 0}',
                                  '${controller.logInfoRx.value.perTimes ?? 3}'
                                ]),
                                size: 22.sp,
                                color: AppColors.color_1A342B,
                                weight: FontWeight.w600),
                            28.horizontalSpace,
                            Expanded(
                              child: TextWidget(
                                text:
                                    'Complete perTimes days log to get trigger report'
                                        .trArgs([
                                  '${controller.logInfoRx.value.perTimes ?? 0}'
                                ]),
                                style: GoogleFonts.openSans(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color_A7998F),
                                maxLines: null,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    )),

                Divider(
                  height: 50.h,
                  color: AppColors.color_E6DCD6,
                ),
                Obx(() => TodaysLog(
                      progress:
                          (controller.logInfoRx.value.progress ?? 0) / 100,
                      goTrack: () => Get.to(LogPage()),
                    )), // 这里是横线
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: DividerImageText(
                    text: 'Assessment'.tr,
                    icon: IconWidget.svg(
                      'assets/svg/ico_assessment.svg',
                      size: 20,
                    ),
                    goDetail: () {
                      Get.to(AssessmentDetailPage(title: 'Assessment'.tr));
                    },
                  ),
                ),

                IconTitleContentArrow(
                    goDetail: () async {
                      Get.toNamed(RouteNames.gutHealthStart);
                    },
                    imageName: 'assets/svg/ico_gut_health.svg',
                    title: 'Gut Health'.tr,
                    subTitle:
                        'Gut Health Description'
                            .tr),

                const Divider(
                  height: 40,
                  color: AppColors.color_E6DCD6,
                ),

                IconTitleContentArrow(
                    goDetail: () {
                      Get.toNamed(RouteNames.bodyTypeStart);
                    },
                    imageName: 'assets/svg/ico_body_type.svg',
                    title: 'Body Type'.tr,
                    subTitle:
                        'Body Type Description'
                            .tr),

                const Divider(
                  height: 40,
                  color: AppColors.color_E6DCD6,
                ),
                TextWidget(
                  text: 'Customized \nHealth Plan'.tr,
                  size: 22.sp,
                  color: AppColors.color_1A342B,
                  weight: FontWeight.w700,
                  maxLines: null,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView(
                  shrinkWrap: true, // 设置为true，使得GridView根据内容的高度进行收缩
                  physics:
                      const NeverScrollableScrollPhysics(), // 禁用GridView的滚动
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  children: [
                    Obx(() => PlanImageTextProgress(
                          title: 'Diet'.tr,
                          isShowNew: controller.logInfoRx.value.dietFlag,
                          imagePath: 'assets/svg/dietplan.svg',
                          goDetail: () => Get.toNamed(RouteNames.diet),
                        )),
                    Obx(() => PlanImageTextProgress(
                          title: 'Herb'.tr,
                          isShowNew: controller.logInfoRx.value.herbFlag,
                          imagePath: 'assets/svg/herbplan.svg',
                          goDetail: () => Get.toNamed(RouteNames.herb),
                        )),
                    Obx(() => PlanImageTextProgress(
                          title: 'Mind'.tr,
                          isShowProgress: true,
                          imagePath: 'assets/svg/mindplan.svg',
                          currTimes:
                              controller.logInfoRx.value.mindInfo?.currTimes,
                          perTimes:
                              controller.logInfoRx.value.mindInfo?.perTimes,
                          goDetail: () async {
                            await Get.toNamed(RouteNames.mind);
                            controller.fetchHomeLogInfo();
                          },
                        )),
                    Obx(() => PlanImageTextProgress(
                          title: 'Body'.tr,
                          isShowProgress: true,
                          imagePath: 'assets/svg/bodyplan.svg',
                          currTimes:
                              controller.logInfoRx.value.bodyInfo?.currTimes,
                          perTimes:
                              controller.logInfoRx.value.bodyInfo?.perTimes,
                          goDetail: () async {
                            await Get.toNamed(RouteNames.body);
                            controller.fetchHomeLogInfo();
                          },
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageController extends GetxController {
  Rx<HomeTipsModel> tipsRx = HomeTipsModel().obs;
  Rx<HomeLogInfoModel> logInfoRx = HomeLogInfoModel().obs;
  String get username => Get.find<UserService>().username;

  @override
  void onInit() {
    super.onInit();
    if (Get.find<AuthService>().isAuth) {
      _fetchHomeTips();
      fetchHomeLogInfo();
    }
  }

  Future<void> _fetchHomeTips() async {
    tipsRx.value = await HomeAPI.fetchHomeTips();
  }

  Future<void> fetchHomeLogInfo() async {
    logInfoRx.value = await HomeAPI.fetchHomeLogInfo();
  }
}
