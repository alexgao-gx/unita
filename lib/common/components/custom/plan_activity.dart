import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

class PlanActivityWidget extends StatelessWidget {
  const PlanActivityWidget(
      {super.key,
      required this.svgPath,
      required this.title,
      this.subTitle,
      required this.newFlag, this.currTimes, this.perTimes, this.onTap});
  final String svgPath;
  final String title;
  final String? subTitle;
  final bool newFlag;
  final num? currTimes;
  final num? perTimes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: AppColors.color_C1E1CE,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (subTitle != null)
              TextWidget(
                text: subTitle!,
                maxLines: null,
                softWrap: true,
                style: GoogleFonts.openSans(
                    fontSize: 12.sp,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_1A342B),
              ).paddingSymmetric(horizontal: 13.w, vertical: 10.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 24.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                color: AppColors.color_F3F7ED,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconWidget.svg(
                    size: 60.w,
                    svgPath,
                  ),
                  14.horizontalSpace,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          TextWidget(
                              text: title,
                              size: 20.sp,
                              weight: FontWeight.w700,
                              color: AppColors.color_1A342B),
                          10.horizontalSpace,
                          Visibility(
                              visible: newFlag,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.color_65AF7C),
                                child: TextWidget(
                                  text: 'NEW'.tr,
                                  size: 10.sp,
                                  weight: FontWeight.w600,
                                  color: AppColors.color_FFFCF5,
                                ),
                              ))
                        ],
                      ),
                      5.verticalSpace,
                      _buildProgress(),
                    ],
                  ).expanded()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProgress() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
              text: '${currTimes ?? 0} / ${perTimes ?? 0}',
              style: GoogleFonts.openSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.color_1A342B,
              ),),
          8.horizontalSpace,
          SizedBox(
            width: 64.w,
            height: 2.h,
            child: LinearProgressIndicator(
              value: (perTimes ?? 0) == 0
                  ? 0
                  : ((currTimes ?? 0) / perTimes!), // 设置进度值，范围从0到1
              // minHeight: 10, // 设置指示器的最小高度
              borderRadius: BorderRadius.circular(1.r),
              backgroundColor: AppColors.color_E6DCD6, // 设置指示器的背景颜色
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.color_65AF7C), // 设置进度条的颜色
            ),
          )
        ],
      );
    }
}
