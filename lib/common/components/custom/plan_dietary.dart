import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

class PlanDietaryWidget extends StatelessWidget {
  const PlanDietaryWidget(
      {super.key,
      required this.svgPath,
      required this.title,
      required this.subTitle,
      required this.newFlag, this.onTap});
  final String svgPath;
  final String title;
  final String subTitle;
  final bool newFlag;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                        child: TextWidget(
                          text: '•  NEW'.tr,
                          size: 10.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_FD8A5E,
                        ))
                  ],
                ),
                5.verticalSpace,
                TextWidget(
                  text: subTitle,
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_1A342B,
                  ),
                  softWrap: true,
                  maxLines: null,
                ),
              ],
            ).expanded()
          ],
        ),
      ),
    );
  }
}
