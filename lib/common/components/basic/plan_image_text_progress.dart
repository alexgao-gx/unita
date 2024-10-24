import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class PlanImageTextProgress extends StatelessWidget {
  const PlanImageTextProgress(
      {super.key,
      required this.title,
      this.isShowNew,
      this.isShowProgress,
      this.currTimes,
      this.perTimes,
      required this.imagePath,
      required this.goDetail});
  final String title;
  final bool? isShowNew;
  final bool? isShowProgress;
  final num? currTimes;
  final num? perTimes;
  final String imagePath;
  final Function() goDetail;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goDetail();
      },
      child: Container(
        // width: 170,
        // height: 114,
        decoration: BoxDecoration(
            color: AppColors.color_F3F7ED,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: title,
                  weight: FontWeight.w700,
                  color: AppColors.color_204740,
                  size: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildProgressOrNew(),
                  IconWidget.svg(
                    imagePath,
                    width: 50.w,
                    height: 50.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOrNew() {
    if (isShowProgress == true) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextWidget(
            text: 'Day process'.trArgs(['${currTimes ?? 0}', '${perTimes ?? 0}']),
              weight: FontWeight.w400,
              color: AppColors.color_204740,
              size: 10.sp),
          15.horizontalSpace,
          Transform(transform: Matrix4.translationValues(0, -3, 0), child: SizedBox(
            width: 26.w,
            height: 2.h,
            child: LinearProgressIndicator(
              value: (perTimes ?? 0) == 0
                  ? 0
                  : ((currTimes ?? 0) / perTimes!), // 设置进度值，范围从0到1
              // minHeight: 10, // 设置指示器的最小高度
              borderRadius: BorderRadius.circular(1.r),
              backgroundColor: AppColors.color_D9D9D9, // 设置指示器的背景颜色
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.color_65AF7C), // 设置进度条的颜色
            ),
          ),)
        ],
      );
    } else if (isShowNew == true) {
      return TextWidget(
        text: '•  NEW'.tr,
        size: 10.sp,
        weight: FontWeight.w600,
        color: AppColors.color_FD8A5E,
      );
    }
    return SizedBox.shrink();
  }
}
