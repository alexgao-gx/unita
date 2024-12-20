import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import '../../../common/components/basic/app_bar.dart';
import '../../../common/components/basic/container_text.dart';
import '../../../common/components/basic/large_title.dart';
import '../../../common/components/basic/loading_button.dart';
import '../../../common/components/custom/step_progress_bar.dart';
import '../../../common/models/assessment_page_model.dart';

class GutHealthAssessmentPage<T extends GutHealthAssessmentPageController>
    extends GetView<GutHealthAssessmentPageController> {
  const GutHealthAssessmentPage(
      {super.key, required this.assessmentIndex, required this.assessments});

  final int assessmentIndex;
  final List<AssessmentPageModel> assessments;

  @override
  String get tag => assessmentIndex.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(
        GutHealthAssessmentPageController(
            index: assessmentIndex, assessments: assessments),
        tag: assessmentIndex.toString());
    return Scaffold(
      appBar: appBar(
          elevation: 0,
          titleWidget: Obx(() => TextWidget(
                text: controller.assessmentRx.value.navTitle ?? '',
                size: 16.sp,
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,
              ))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StepProgressBar(
                currentStep: assessmentIndex + 1,
                totalSteps: assessments.length),
            Obx(() => LargeTitle(
                text: controller.assessmentRx.value.title ?? '',
                fontSize: 28.sp)),
            Obx(() => Visibility(
                visible: !controller.isSingleSelectRx.value,
                child: TextWidget(
                  text: '*Multiple Choice'.tr,
                  style: GoogleFonts.openSans(
                      fontSize: 12.sp,
                      color: AppColors.color_456C51,
                      fontWeight: FontWeight.w400),
                ))),
            15.verticalSpace,
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.optionsRx.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.optionsRx[index];
                  return Obx(() => ContainerText(
                      tapAction: () {
                        if (controller.isSingleSelectRx.value) {
                          controller.optionsRx.forEach((v) =>
                              v.isSelected.value = v.value == item.value);
                        } else {
                          item.isSelected.value = !item.isSelected.value;
                        }
                        // Check if a child question needs to be shown
                        controller.updateChildQuestionVisibility(item);
                      },
                      bgColor: item.isSelected.value
                          ? AppColors.color_C1E1CE
                          : AppColors.color_FFFCF5,
                      borderRadius: 10.r,
                      verPadding: 10.h,
                      borderWidth: item.isSelected.value ? 0 : 0.5,
                      text: item.title ?? '',
                      textSize: 16.sp,
                      textWeight: FontWeight.w500,
                      textColor: AppColors.color_1A342B));
                },
                separatorBuilder: (_, __) => 8.verticalSpace,
              ),
            ),
            // Render child question if visible
            Obx(() => controller.showChildQuestionRx.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      20.verticalSpace,
                      LargeTitle(
                        text: controller.childQuestionTitleRx?.value ?? '',
                        fontSize: 24.sp,
                      ),
                      15.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.childOptionsRx.length,
                        itemBuilder: (BuildContext context, int index) {
                          var childItem = controller.childOptionsRx[index];
                          return Obx(() => ContainerText(
                              tapAction: () {
                                childItem.isSelected.value =
                                    !childItem.isSelected.value;
                              },
                              bgColor: childItem.isSelected.value
                                  ? AppColors.color_C1E1CE
                                  : AppColors.color_FFFCF5,
                              borderRadius: 10.r,
                              verPadding: 10.h,
                              borderWidth: childItem.isSelected.value ? 0 : 0.5,
                              text: childItem.title ?? '',
                              textSize: 16.sp,
                              textWeight: FontWeight.w500,
                              textColor: AppColors.color_1A342B));
                        },
                        separatorBuilder: (_, __) => 8.verticalSpace,
                      ),
                    ],
                  )
                : Container()),
          ],
        ).paddingHorizontal(14.w),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        controllerTag: tag,
        padding:
            EdgeInsets.only(left: 73.w, right: 73.w, bottom: 20.h, top: 20.h),
        onPressed: () {},
      ),
    );
  }
}

class GutHealthAssessmentPageController extends LoadingButtonController {
  GutHealthAssessmentPageController(
      {required this.index, required this.assessments});

  final int index;
  final List<AssessmentPageModel> assessments;

  Rx<AssessmentPageModel> assessmentRx = AssessmentPageModel().obs;
  RxList<AssessmentOptionModel> optionsRx = <AssessmentOptionModel>[].obs;
  RxBool isSingleSelectRx = false.obs;
  RxBool showChildQuestionRx = false.obs;
  RxString? childQuestionTitleRx = ''.obs;
  RxList<AssessmentOptionModel> childOptionsRx = <AssessmentOptionModel>[].obs;

  @override
  void onInit() {
    // Set up the main question and options
    assessmentRx.value = assessments[min(index, assessments.length - 1)];
    optionsRx.value =
        assessmentRx.value.itemList ?? <AssessmentOptionModel>[].obs;
    isSingleSelectRx.value = assessmentRx.value.choice == "SINGLE";
    super.onInit();
  }

  void updateChildQuestionVisibility(AssessmentOptionModel selectedOption) {
    // Check if the selected option triggers a child question (e.g., Q001_1)
    // if (selectedOption.value == "OP001") {
    //   // Example: Option with value OP001 triggers child question
    //   showChildQuestionRx.value = true;
    //   childQuestionTitleRx?.value = "How often does the bloating occur?";
    //   childOptionsRx.value = [
    //     AssessmentOptionModel(title: "Daily", value: "OP101"),
    //     AssessmentOptionModel(title: "Weekly", value: "OP102"),
    //     AssessmentOptionModel(title: "Occasionally", value: "OP103"),
    //   ];
    // } else {
    //   showChildQuestionRx.value = false;
    //   childOptionsRx.clear();
    // }
  }

  @override
  bool loadingButtonEnabled() =>
      optionsRx.where((v) => v.isSelected.value).isNotEmpty ||
      childOptionsRx.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() {
    if (index + 1 >= assessments.length) {
      Get.toNamed(RouteNames.gutHealthDone);
    } else {
      Get.toNamed(RouteNames.gutHealthAssessment,
          arguments: {'assessmentIndex': index + 1, 'assessments': assessments},
          preventDuplicates: false);
    }
    return Future.value(false);
  }
}
