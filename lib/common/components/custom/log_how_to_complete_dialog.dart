import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

class LogHowToCompleteDialog extends StatefulWidget {
  const LogHowToCompleteDialog({super.key});
  @override
  _LogHowToCompleteDialogState createState() => _LogHowToCompleteDialogState();
}

class _LogHowToCompleteDialogState extends State<LogHowToCompleteDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 44.w),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(14.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
                    text: 'How to complete'.tr,
                    size: 16.sp,
                    weight: FontWeight.w600,
                    color: AppColors.color_1A342B)
                .padding(vertical: 17.h),
            TextWidget(
              text:
                  'Record at least two meals or snack and one symptom to complete today\'s log.'.tr,
              maxLines: null,
              softWrap: true,
              style: GoogleFonts.openSans(
                  color: AppColors.color_1A342B,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.3),
            ),
            20.verticalSpace,
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconWidget.svg(
                        'assets/svg/ico_dietary_sel.svg',
                        height: 30.w,
                        width: 30.w,
                      ),
                      5.horizontalSpace,
                      TextWidget(
                          text: 'X 2',
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_1A342B)
                    ],
                  )),
                  VerticalDivider(
                    indent: 5.h,
                    endIndent: 5.h,
                    color: AppColors.color_E6DCD6,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      IconWidget.svg(
                        'assets/svg/ico_symptoms_sel.svg',
                        height: 30.w,
                        width: 30.w,
                      ),
                      5.horizontalSpace,
                      TextWidget(
                          text: 'X 1',
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_1A342B)
                    ],
                  )),
                ],
              ),
            ),
            10.verticalSpace,
            Divider(
                endIndent: 30.w,
                indent: 30.w,
                color: AppColors.color_E6DCD6,
                thickness: 0.5),
            SizedBox(
              height: 52.h,
              child: CupertinoButton(
                  child: TextWidget(
                      text: 'Close'.tr,
                      size: 16.sp,
                      weight: FontWeight.w600,
                      color: AppColors.color_65AF7C),
                  onPressed: () async {
                    Get.back();
                  }),
            ).padding(horizontal: 30.w)
          ],
        ).paddingHorizontal(16.w),
      ),
    );
  }
}
