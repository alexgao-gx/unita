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

class GutHealthStartPage extends GetView<AssessmentService> {
  const GutHealthStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssessmentService()).fetchGutHealthAssessment();
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconWidget.svg('assets/svg/ico_gut_health_start.svg',
                width: 278.w, height: 184.h, fit: BoxFit.contain)
                .padding(horizontal: 49.w, vertical: 20.h),
            Padding(
                padding: EdgeInsets.fromLTRB(14.w, 25.h, 14.w, 20.h),
                child: TextWidget(
                  text:
                  "Current Syndrome Pattern in Traditional Chinese Medicine".tr,
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
                "Syndrome differentiation is the comprehensive analysis of a patient's clinical symptoms in traditional Chinese medicine. It is the basis for treatment planning.".tr,
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color_1A342B,
                ),
                maxLines: null,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      SafeArea(
        minimum: EdgeInsets.only(left: 73.w, right: 73.w, bottom: 72.h),
        child: ContainerTextIcon(
            goDetail: () {
              if (controller.gutHealthAssessments.isNotEmpty) {
                Get.toNamed(RouteNames.gutHealthAssessment, arguments: {
                  'assessmentIndex': 0,
                  'assessments': controller.gutHealthAssessments
                });
              }
            },
            svgPath: 'assets/svg/signupbtnarrow.svg',
            title: 'Start Now'.tr,
            backgroundColor: AppColors.color_FFFCF5,
            height: 44.h,
            width: 169.w),
      )

    );
  }
}
