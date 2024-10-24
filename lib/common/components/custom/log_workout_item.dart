import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

import '../../style/colors.dart';
import '../../widgets/text.dart';

class LogWorkItemWidget extends StatelessWidget {
  const LogWorkItemWidget(
      {super.key,
      required this.title,
      required this.hours,
      this.iconName,
      this.onTap});

  final String title;
  final double hours;
  final String? iconName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor:
            hours > 0 ? AppColors.color_C1E1CE : AppColors.color_FFFCF5,
            padding:
                EdgeInsets.only(left: 14.w, right: 5.w, top: 8.h, bottom: 8.h),
            shape: const StadiumBorder(),
            side: hours > 0
                ? BorderSide.none
                : BorderSide(color: AppColors.color_A7998F, width: 0.1)),
        onPressed: onTap,
        child: Row(
          children: [
            if (iconName != null)
              IconWidget.svg(
                size: 30.w,
                'assets/svg/$iconName',
                color:
                hours > 0 ? AppColors.color_1A342B : AppColors.color_A7998F,
              ),
            10.horizontalSpace,
            TextWidget(
              text: title, // 左边的文字
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  color: hours > 0
                      ? AppColors.color_1A342B
                      : AppColors.color_A7998F,
                  fontSize: 14.sp),
            ),
            Expanded(
              child: Visibility(
                  visible: hours > 0,
                  child: TextWidget(
                    text: '$hours',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.color_1A342B,
                        fontSize: 12.sp),
                  )),
            ),
            Visibility(
              visible: hours > 0,
              child: IconWidget.svg(
                size: 26.w,
                'assets/svg/ico_enter.svg',
              ),
            ),
            Visibility(
                visible: hours <= 0,
                child: IconWidget.svg(
                  size: 20.w,
                  'assets/svg/ico_plus_outlined.svg',
                ).padding(horizontal: 10.w))
          ],
        ));
  }
}
