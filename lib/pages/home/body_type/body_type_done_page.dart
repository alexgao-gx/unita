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

class BodyTypeDonePage extends GetView<BodyTypeDonePageController> {
  BodyTypeDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BodyTypeDonePageController());
    return Scaffold(
      backgroundColor: AppColors.color_F8EFE9,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAssessmentHeader(),
          45.verticalSpace,
          TextWidget(
            text: 'Well done on finishing\nBody Type Assessment'.tr,
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
                'assets/svg/ico_body_type_divider.svg',
                size: 22.w,
              ),
              goDetail: () {},
            ),
          ).padding(horizontal: 44.w, vertical: 20.h),
          TextWidget(
            text:
                'Your collaboration with Gut Health Assessment and Daily Log will help us thoroughly analyze the underlying causes of your symptoms.'.tr,
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
  Widget _buildAssessmentHeader() => AspectRatio(
        aspectRatio: 581 / 562,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: 100.h,
                  color: Colors.white,
                )),
            IconWidget.svg(
              'assets/svg/ico_body_type_header_bg.svg',
              fit: BoxFit.fill,
            ),
            IconWidget.svg(
              'assets/svg/img_TCMend_noBG.svg',
              fit: BoxFit.contain,
            ).paddingTop(kMinInteractiveDimension)
          ],
        ),
      );
}

class BodyTypeDonePageController extends GetxController {}
