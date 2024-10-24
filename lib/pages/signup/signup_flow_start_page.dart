import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_icon.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';

class SignupFlowStartPage extends StatelessWidget {
  const SignupFlowStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: appBar(),
        backgroundColor: AppColors.color_F8EFE9,
        // extendBodyBehindAppBar: true,
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconWidget.svg('assets/svg/img_break.svg',
                    height: 412.h, fit: BoxFit.contain),
                Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 33.h, 14.w, 69.h),
                    child:  TextWidget(
                      text:
                          "Welcome to Unita! \nWe're excited to \nget to know you \nbetter.".tr,
                      textAlign: TextAlign.center,
                      maxLines: null,
                      softWrap: true,
                      size: 32.sp,
                      weight: FontWeight.w600,
                      color: AppColors.color_1A342B,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 73.w),
                  child: ContainerTextIcon(
                      goDetail: () {
                        Get.toNamed(RouteNames.signupFlowIdentify);
                      },
                      svgPath: 'assets/svg/signupbtnarrow.svg',
                      title: 'Start Now'.tr,
                      backgroundColor: AppColors.color_F8EFE9,
                      height: 44.h,
                      width: 169.w),
                ),
                40.verticalSpace,
              ],
            ),
          ),
          Positioned(
            child: _buildNavBack(),
            left: 0,
            top: 0,
          )
        ]));
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
}
