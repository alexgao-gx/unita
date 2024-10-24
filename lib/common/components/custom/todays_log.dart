import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/container_text_icon.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TodaysLog extends StatelessWidget {
  const TodaysLog({super.key, required this.goTrack, this.progress});
  final Function() goTrack;
  final double? progress;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120.w,
          height: 120.h,
          child: CircularPercentIndicator(
            radius: 60.r,
            lineWidth: 8.r,
            animation: true,
            percent: progress ?? 0,
            backgroundColor: AppColors.color_F8EFE9,
            progressColor: AppColors.color_65AF7C,
            center:  TextWidget(
              text:  "${(progress ?? 0) == 0 ? 0 : ((progress ?? 0) * 100).ceil()}%",
              size: 22.sp,
              weight: FontWeight.w600,
              color: AppColors.color_65AF7C,
            ),
            circularStrokeCap: CircularStrokeCap.round,

          ),
        ),
        36.horizontalSpace,
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                text: 'Today’s Log'.tr,
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,
                size: 22.sp),
            8.verticalSpace,
            TextWidget(
              text:
              'Record at least two meals and one symptom to complete today\'s log'.tr,
              maxLines: null,
              softWrap: true,
              style: GoogleFonts.openSans(
                color: AppColors.color_A7998F,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            15.verticalSpace,
            ContainerTextButton(
                tapAction: goTrack,
                bgColor: AppColors.color_65AF7C,
                width: 138,
                height: 35,
                borderRadius: 19,
                text: 'Track'.tr,
                textSize: 16,
                textWeight: FontWeight.w600,
                textColor: AppColors.color_FFFCF5)
          ],
        )),

      ],
    ));
  }
}
