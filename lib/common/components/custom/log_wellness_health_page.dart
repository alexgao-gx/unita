import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/slider_text.dart';
import 'package:unitaapp/common/components/custom/water_tip.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/widgets/index.dart';

import '../../api/auth_api.dart';
import '../../api/log_api.dart';
import '../../models/log_model.dart';
import '../../models/log_req_model.dart';
import '../../models/signup_flow_model.dart';
import '../basic/app_bar.dart';
import 'log_beverage_item.dart';
import 'log_bm_appearances.dart';
import 'log_date_time.dart';
import 'log_mood.dart';
import 'log_workout_counter.dart';
import 'log_workout_item.dart';

class LogWellnessHealthPage extends GetView<LogWellnessHealthPageController> {
  const LogWellnessHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogWellnessHealthPageController());
    return Scaffold(
      appBar: logAppBar(
          title: 'Wellness & Health'.tr,
          titleFontSize: 15,
          onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchWellnessHealthLogInfo();
            }),
            20.verticalSpace,
            Obx(() => LogMoodWidget(
                  moods: controller.moodLevelsRx.value,
                  onMoodChanged: (mood, index) {
                    controller.wellnessInfoRx.value.moodLevel =
                        int.tryParse(mood.value ?? '1');
                  },
                )),
            44.verticalSpace,
            _buildStressLevel(),
            48.verticalSpace,
            _buildWorkout(),
            48.verticalSpace,
            _buildSleep(),
            31.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildStressLevel() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
            border: Border(
                bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextWidget(
              text: 'Stress level'.tr,
              size: 16.sp,
              weight: FontWeight.w500,
              color: AppColors.color_1A342B,
            ).paddingHorizontal(14.w),
            28.verticalSpace,
            Obx(() => SliderTextWidget(
                  datas: controller.stressLevelsRx.value,
                  onValueChanged: (v) {
                    controller.wellnessInfoRx.value.stressLevel =
                        int.tryParse(v.value ?? '1');
                  },
                )),
            36.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  crossAxisCount: 3,
                  childAspectRatio: 2.8,
                  datas: controller.stressTypesRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.wellnessInfoRx.value.stressFeeling =
                        v.value ?? v.text;
                  },
                )),
            46.verticalSpace,
          ],
        ),
      );

  Widget _buildWorkout() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
            border: const Border(
                bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
        child: Column(
          children: [
            Column(
              children: [
                Obx(() => WaterTip(
                      title: 'Workout'.tr,
                      subTitle: 'Today\'s workout has reached'.tr,
                      targetValue: 'xx hours'.trArgs([
                        (Validators.removeTrailingZeros(
                            (controller.workoutReachedIconsRx.length * 0.5)
                                .toString()))
                      ]),
                      icon: 'assets/svg/ico_run_sel.svg',
                      description: '= 0.5 hour'.tr,
                    )),
                11.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.color_F3F7ED,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Obx(() => GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(20.w),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, // 每行6个图标
                          mainAxisSpacing: 13.h, // 主轴间距
                          crossAxisSpacing: 26.w, // 交叉轴间距
                          childAspectRatio: 1,
                        ),
                        itemCount: min(
                            max(controller.workoutReachedIconsRx.length, 12),
                            12),
                        itemBuilder: (BuildContext context, int index) {
                          String imageName;
                          Color? imageColor;
                          if (index < controller.workoutReachedIconsRx.length) {
                            imageName = controller.workoutReachedIconsRx[index];
                            imageColor = AppColors.color_65AF7C;
                          } else {
                            imageName = 'ico_workout_empty.svg';
                          }
                          return IconWidget.svg(
                            size: 30.w,
                            color: imageColor,
                            'assets/svg/$imageName',
                          );
                        },
                      )),
                ),
              ],
            ),
            _buildAllWorkoutsView(),
            20.verticalSpace,
          ],
        ),
      );

  Widget _buildAllWorkoutsView() => GetBuilder(
        id: 'ALL_WORKOUT_VIEW',
        builder: (LogWellnessHealthPageController controller) =>
            ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = controller.allWorkoutsRx[index];
                  final title = item.name ?? '';
                  final count = double.tryParse(item.hours ?? '0') ?? 0;
                  return LogWorkItemWidget(
                    title: title,
                    hours: count,
                    iconName: controller.workoutTypeIconsRx[index],
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => LogWorkoutCounterWidget(
                              workout: item,
                              workoutIconName:
                                  controller.workoutTypeIconsRx[index],
                              onSaved: (v) {
                                double diff = v - count;
                                if (diff > 0) {
                                  // 增加了diff 个icon
                                  final icon =
                                      controller.workoutTypeIconsRx[index];
                                  controller.workoutReachedIconsRx.addAll(
                                      List.generate(
                                          (diff * 2).ceil(), (_) => icon));
                                } else if (diff < 0) {
                                  // 减少了diff 个icon
                                  final icon =
                                      controller.workoutTypeIconsRx[index];
                                  for (int i = 0;
                                      i < (diff * 2).ceil().abs();
                                      i++) {
                                    controller.workoutReachedIconsRx
                                        .remove(icon);
                                  }
                                }
                                item.hours = '$v';
                                controller.update(['ALL_WORKOUT_VIEW'], true);
                              },
                              onRemove: () {
                                // 全部移除
                                final icon =
                                    controller.workoutTypeIconsRx[index];
                                controller.workoutReachedIconsRx
                                    .removeWhere((e) => icon == e);
                                item.hours = '0';
                                controller.update(['ALL_WORKOUT_VIEW'], true);
                              }));
                    },
                  );
                },
                separatorBuilder: (_, __) => 10.verticalSpace,
                itemCount: controller.allWorkoutsRx.length),
      );

  Widget _buildSleep() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
            text: 'Sleep'.tr,
            size: 24.sp,
            weight: FontWeight.w700,
            color: AppColors.color_1A342B,
          ).paddingHorizontal(14.w),
          32.verticalSpace,
          TextWidget(
            text: 'How long have you sleep?'.tr,
            size: 16.sp,
            weight: FontWeight.w500,
            color: AppColors.color_1A342B,
          ).paddingHorizontal(14.w),
          28.verticalSpace,
          Obx(() => SliderTextWidget(
                datas: controller.sleepHoursRx.value,
                onValueChanged: (v) {
                  controller.wellnessInfoRx.value.sleepHours = v.value;
                },
              )),
          36.verticalSpace,
          Obx(() => LogBmAppearancesWidget(
                crossAxisCount: 3,
                childAspectRatio: 2.8,
                datas: controller.sleepFeelsRx.value,
                onBmAppearanceChanged: (v) {
                  controller.wellnessInfoRx.value.sleepFeeling =
                      v.value ?? v.text;
                },
              )),
          30.verticalSpace,
        ],
      );
}

class LogWellnessHealthPageController extends GetxController {
  Rx<DateTime> dateRx = DateTime.now().obs;
  RxList<EnumModel> moodLevelsRx = <EnumModel>[].obs;
  RxList<EnumModel> stressLevelsRx = <EnumModel>[].obs;
  RxList<EnumModel> stressTypesRx = <EnumModel>[].obs;
  RxList<EnumModel> sleepHoursRx = <EnumModel>[].obs;
  RxList<EnumModel> sleepFeelsRx = <EnumModel>[].obs;
  RxList<Workout> allWorkoutsRx = <Workout>[].obs;
  Rx<WellnessHealthInfo> wellnessInfoRx = WellnessHealthInfo().obs;

  RxList<String> workoutReachedIconsRx =
      List.generate(12, (_) => 'ico_workout_empty.svg').obs;

  RxList<String> workoutTypeIconsRx = <String>[
    'ico_CardiovascularExercises_sel.svg',
    'ico_StrengthTraining_sel.svg',
    'ico_Flexibility&BalanceExercises_nor.svg',
    'ico_HIITt_nor.svg',
    'ico_Low-ImpactExercises_sel.svg',
    'ico_TeamSport_nor.svg',
    'ico_MindBody_nor.svg',
  ].obs;

  @override
  void onInit() {
    fetchWellnessHealthLogInfo();
    super.onInit();
  }

  Future<void> _fetchWellnessMoods() async {
    final resp = await AuthAPI.fetchSignupFlows([
      'MoodLevelEnum',
      'StressLevelEnum',
      'StressTypeEnum',
      'SleepHourEnum',
      'SleepFeelEnum'
    ]);
    if (moodLevelsRx.isEmpty) {
      moodLevelsRx.value = resp.moodLevelEnum ?? <EnumModel>[].obs;
    }
    if (stressLevelsRx.isEmpty) {
      stressLevelsRx.value = resp.stressLevelEnum ?? <EnumModel>[].obs;
    }
    if (stressTypesRx.isEmpty) {
      stressTypesRx.value = resp.stressTypeEnum ?? <EnumModel>[].obs;
    }
    if (sleepHoursRx.isEmpty) {
      sleepHoursRx.value = resp.sleepHourEnum ?? <EnumModel>[].obs;
    }
    if (sleepFeelsRx.isEmpty) {
      sleepFeelsRx.value = resp.sleepFeelEnum ?? <EnumModel>[].obs;
    }
  }

  Future<void> fetchWellnessHealthLogInfo() async {
    await _fetchWellnessMoods();
    final logInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.WELLNESS_HEALTH], logDate: dateRx.value);
    wellnessInfoRx.value = logInfo.wellnessHealthInfo ?? WellnessHealthInfo();
    // Mood Level
    moodLevelsRx.value = moodLevelsRx.map((e) {
      if (wellnessInfoRx.value.moodLevel != null) {
        e.isSelected.value =
            e.value == wellnessInfoRx.value.moodLevel.toString();
      }
      return e;
    }).toList();

    // Stress Level
    stressLevelsRx.value = stressLevelsRx.map((e) {
      if (wellnessInfoRx.value.stressLevel != null) {
        e.isSelected.value =
            e.value == wellnessInfoRx.value.stressLevel.toString();
      }
      return e;
    }).toList();

    // stressTypesRx
    final stressLevelTypes = stressTypesRx
        .where((e) => e.value == logInfo.wellnessHealthInfo?.stressFeeling);

    if (stressLevelTypes.isEmpty &&
        logInfo.wellnessHealthInfo?.stressFeeling != null) {
      stressTypesRx.add(EnumModel(
          value: logInfo.wellnessHealthInfo?.stressFeeling,
          text: logInfo.wellnessHealthInfo?.stressFeeling));
    }
    stressTypesRx.value = stressTypesRx
        .map((e) => e
          ..isSelected.value =
              e.value == logInfo.wellnessHealthInfo?.stressFeeling)
        .toList();

    // Sleep Hours
    sleepHoursRx.value = sleepHoursRx.map((e) {
      if (wellnessInfoRx.value.sleepHours != null) {
        e.isSelected.value =
            e.value == wellnessInfoRx.value.sleepHours.toString();
      }
      return e;
    }).toList();

    // sleepFeelsRx
    final sleepFeelTypes = sleepFeelsRx
        .where((e) => e.value == logInfo.wellnessHealthInfo?.sleepFeeling);

    if (sleepFeelTypes.isEmpty &&
        logInfo.wellnessHealthInfo?.sleepFeeling != null) {
      sleepFeelsRx.add(EnumModel(
          value: logInfo.wellnessHealthInfo?.sleepFeeling,
          text: logInfo.wellnessHealthInfo?.sleepFeeling));
    }
    sleepFeelsRx.value = sleepFeelsRx
        .map((e) => e
          ..isSelected.value =
              e.value == logInfo.wellnessHealthInfo?.sleepFeeling)
        .toList();
    await _fetchWorkouts(wellnessInfoRx.value.workout ?? <Workout>[]);
  }

  Future<void> _fetchWorkouts(List<Workout> logWorkoutInfo) async {
    final resp = await AuthAPI.fetchSignupFlows(['WorkoutEnum']);
    final workoutEnums = resp.workoutEnum?.sublist(
        0, min(workoutTypeIconsRx.length, resp.workoutEnum?.length ?? 0));
    allWorkoutsRx.value = workoutEnums?.map((e) {
          Workout workout = logWorkoutInfo.singleWhere((v) => v.code == e.value,
              orElse: () => Workout());
          String hours = '0';
          if (workout.code != null) {
            hours = workout.hours ?? '0';
          }
          return Workout(code: e.value, name: e.text, hours: hours);
        }).toList() ??
        <Workout>[];
    update(['ALL_WORKOUT_VIEW'], true);

    List<String> reachedIcons = <String>[];
    logWorkoutInfo.forEach((e) {
      int count = ((double.tryParse(e.hours ?? '0') ?? 0) * 2).toInt();
      int index = allWorkoutsRx.indexWhere((v) => v.code == e.code);
      String icon = workoutTypeIconsRx[index];
      final icons = List.generate(count, (_) => icon);
      reachedIcons.addAll(icons);
    });
    workoutReachedIconsRx.value = reachedIcons;
  }

  Future<void> onSaveAll() async {
    final works = allWorkoutsRx
        .where((work) => work.hours != null && double.parse(work.hours!) > 0)
        .toList();
    final mood = moodLevelsRx.singleWhere((e) => e.isSelected.value == true,
        orElse: () => EnumModel());
    final stress = stressLevelsRx.singleWhere((e) => e.isSelected.value == true,
        orElse: () => EnumModel());
    final hours = sleepHoursRx.singleWhere((e) => e.isSelected.value == true,
        orElse: () => EnumModel());
    await LogAPI.saveLogInfo(LogReqModel(
        wellnessHealthInfo: wellnessInfoRx.value
          ..workout = works
          ..moodLevel = int.tryParse(mood.value ?? '')
          ..stressLevel = int.tryParse(stress.value ?? '')
          ..sleepHours = hours.value,
        logType: LogType.WELLNESS_HEALTH.name));

    await fetchWellnessHealthLogInfo();
    Get.back();
  }
}
