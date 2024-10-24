import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';

import '../../../common/components/basic/container_text.dart';
import '../../../common/components/basic/devider_image_text.dart';

class GutFlowDonePage extends GetView<GutFlowDonePageController> {
  GutFlowDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GutFlowDonePageController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGutAssessmentHeader(),
          45.verticalSpace,
          TextWidget(
            text: 'Well done on finishing\nGut Health Assessment'.tr,
            size: 18.sp,
            weight: FontWeight.w600,
            color: AppColors.color_1A342B,
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          Center(
            child: DividerImageText(
              text: '',
              icon: IconWidget.svg(
                'assets/svg/ico_gut_done.svg',
                size: 22.w,
              ),
              goDetail: () {},
            ),
          ).padding(horizontal: 44.w, vertical: 20.h),
          TextWidget(
            text:
                'Your collaboration with Body Type Assessment and Daily Log will help us thoroughly analyze the underlying causes of your symptoms.'.tr,
            style: GoogleFonts.openSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color_1A342B,
            ),
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.center,
          ).paddingHorizontal(44.w),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(left: 73.w, right: 73.w, bottom: 72.h),
        child: ContainerText(
          tapAction: () {
            Get.offAllNamed(RouteNames.main);
          },
          bgColor: Colors.transparent,
          text: 'Back to home'.tr,
          textSize: 16.sp,
          textWeight: FontWeight.w600,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          textColor: AppColors.color_1A342B,
          borderRadius: 44.h,
          borderWidth: 0.5,
          borderColor: AppColors.color_1A342B,
          height: 44.h,
        ),
      ),
    );
  }

  Widget _buildNavBack() => SafeArea(
          child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.back();
        },
        child: IconWidget.svg(
          'assets/svg/ico_back.svg',
          width: 48.r,
          height: 48.r,
        ),
      ));

  Widget _buildGutAssessmentHeader() => Container(
        height: 320.h,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            IconWidget.svg(
              'assets/svg/ico_gut_done_bg.svg',
              fit: BoxFit.fill,
            ),
            Positioned(
                width: 170.w,
                height: 194.h,
                child: IconWidget.svg(
                  'assets/svg/ico_gut_done_assessment.svg',
                ))
            // Positioned(
            //   child: _buildNavBack(),
            //   left: 0,
            //   top: 0,
            // )
          ],
        ),
      );
}

class GutFlowDonePageController extends GetxController {}
