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
import '../../../common/models/assessment_page_model.dart';

class BodyTypeAssessmentPage<T extends BodyTypeAssessmentPageController>
    extends GetView<BodyTypeAssessmentPageController> {
  const BodyTypeAssessmentPage(
      {super.key, required this.assessmentIndex, required this.assessments});

  final int assessmentIndex;
  final List<AssessmentPageModel> assessments;

  @override
  String get tag => assessmentIndex.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(
        BodyTypeAssessmentPageController(
            index: assessmentIndex, assessments: assessments),
        tag: assessmentIndex.toString());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildNavSubTitle(),
            Obx(() => LargeTitle(
                text: controller.assessmentRx.value.title ?? '',
                fontSize: 28.sp)),
            10.verticalSpace,
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
          ],
        ).paddingHorizontal(14.w),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        controllerTag: tag,
        padding:
            EdgeInsets.only(left: 73.w, right: 73.w, bottom: 72.h, top: 20.h),
        onPressed: () {},
      ),
    );
  }

  Widget _buildNavSubTitle() => Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconWidget.svg(controller.iconPathRx.value,
              width: 44.w, height: 44.w, fit: BoxFit.contain),
          10.horizontalSpace,
          SizedBox(
            width: 135.w,
            child: TextWidget(
                text: controller.assessmentRx.value.navTitle ?? '',
                style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    color: AppColors.color_65AF7C,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3),
                maxLines: null,
                softWrap: true),
          ),
        ],
      ));
}

class BodyTypeAssessmentPageController extends LoadingButtonController {
  BodyTypeAssessmentPageController(
      {required this.index, required this.assessments});

  final int index;
  final List<AssessmentPageModel> assessments;

  Rx<AssessmentPageModel> assessmentRx = AssessmentPageModel().obs;
  RxList<AssessmentOptionModel> optionsRx = <AssessmentOptionModel>[].obs;
  RxString iconPathRx = 'assets/svg/ico_body_type_bc.svg'.obs;
  RxBool isSingleSelectRx = false.obs;

  @override
  void onInit() {
    // PAGE ASSESSMENT MODEL
    assessmentRx.value = assessments[min(index, assessments.length - 1)];

    // PAGE ASSESSMENT OPTIONS
    optionsRx.value =
        assessmentRx.value.itemList ?? <AssessmentOptionModel>[].obs;

    // PAGE ICON
    if (assessmentRx.value.icon != null) {
      iconPathRx.value =
          'assets/svg/ico_body_type_${assessmentRx.value.icon!.toLowerCase()}.svg';
    }
    // SINGLE / MULTIPLE SELECTION
    isSingleSelectRx.value = assessmentRx.value.choice == "SINGLE";

    super.onInit();
  }

  @override
  bool loadingButtonEnabled() =>
      optionsRx.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() {
    if (index + 1 >= assessments.length) {
      // LAST ASSESSMENT, PAGE TO END
      Get.toNamed(RouteNames.bodyTypeDone);
    } else {
      // NEXT ASSESSMENT
      Get.toNamed(RouteNames.bodyTypeAssessment,
          arguments: {'assessmentIndex': index + 1, 'assessments': assessments},
          preventDuplicates: false);
    }
    return Future.value(false);
  }
}
