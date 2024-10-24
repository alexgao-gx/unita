import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_icon.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/assessment_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';

class BodyTypeStartPage extends GetView<AssessmentService> {
  const BodyTypeStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssessmentService()).fetchBodyTypeAssessment();
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            70.verticalSpace,
            IconWidget.svg('assets/svg/body_type_start_cover.svg',
                    width: 296.w, height: 145.h, fit: BoxFit.contain)
                .padding(horizontal: 40.w),
            36.verticalSpace,
            Padding(
                padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 20.h),
                child: TextWidget(
                  text: "TCM Constitution".tr,
                  maxLines: null,
                  softWrap: true,
                  size: 28.sp,
                  weight: FontWeight.w600,
                  color: AppColors.color_1A342B,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: TextWidget(
                text:
                    "The nine-type constitution categorizes human body constitution into nine types based on TCM theory. These types reflect an individual's physical structure, physiological functions, and psychological state shaped by genetics and environment. Constitutional type affects disease susceptibility and treatment response.".tr,
                style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_1A342B,
                    letterSpacing: -0.3),
                maxLines: null,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(left: 73.w, right: 73.w, bottom: 72.h),
        child: ContainerTextIcon(
            goDetail: () {
              if (controller.bodyTypeAssessments.isNotEmpty) {
                Get.toNamed(RouteNames.bodyTypeAssessment, arguments: {
                  'assessmentIndex': 0,
                  'assessments': controller.bodyTypeAssessments
                });
              }
            },
            svgPath: 'assets/svg/signupbtnarrow.svg',
            title: 'Start Now'.tr,
            backgroundColor: AppColors.color_FFFCF5,
            height: 44.h,
            width: 169.w),
      ),
    );
  }
}
