import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class WaterTip extends StatelessWidget {
  const WaterTip({
    super.key,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.icon,
    this.targetValue,
  });
  final String title;
  final String subTitle;
  final String? targetValue;
  final String description;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextWidget(
                    text: title,
                    weight: FontWeight.w700,
                    color: AppColors.color_1A342B,
                    size: 24.sp),
              ),
              IconWidget.svg(
                icon,
                size: 20.w,
              ),
              const SizedBox(width: 5), // 图片和文字之间的间距
              TextWidget(
                text: description,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    color: AppColors.color_456C51,
                    fontSize: 12.sp),
              ),
            ],
          ),
          8.verticalSpace,
          Row(
            children: [
              TextWidget(
                  text: targetValue ?? '',
                  weight: FontWeight.w500,
                  color: AppColors.color_65AF7C,
                  size: 16.sp),
              10.horizontalSpace,
              TextWidget(
                text: subTitle,
                maxLines: null,
                softWrap: true,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_A7998F,
                    fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
