import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

class LogAddInputDialog extends StatefulWidget {
  final ValueChanged<String>? onValueUpdated;

  const LogAddInputDialog({super.key, this.onValueUpdated});
  @override
  _LogAddInputDialogState createState() => _LogAddInputDialogState();
}

class _LogAddInputDialogState extends State<LogAddInputDialog> {
  final _inputC = TextEditingController();

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
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(14.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
                    text: 'Add'.tr,
                    size: 16.sp,
                    weight: FontWeight.w600,
                    color: AppColors.color_1A342B)
                .padding(vertical: 17.h),
            SizedBox(
              height: 44.h,
              child: InputWidget.textBorder(
                borderRadius: 6.r,
                borderColor: AppColors.color_E6DCD6,
                controller: _inputC,
                fillColor: Colors.white,
                hintText: 'Add'.tr,
                hintStyle: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color_E6DCD6,
                ),
              ).marginSymmetric(horizontal: 30.w),
            ),
            20.verticalSpace,
            Divider(
                endIndent: 30.w,
                indent: 30.w,
                color: AppColors.color_E6DCD6,
                thickness: 0.5),
            SizedBox(
              height: 52.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                      child: TextWidget(
                          text: 'Cancel'.tr,
                          size: 16.sp,
                          weight: FontWeight.w400,
                          color: AppColors.color_A7998F),
                      onPressed: () {
                        Get.back();
                      }),
                  VerticalDivider(
                    endIndent: 15.w,
                    indent: 15.w,
                    width: 5,
                    color: AppColors.color_E6DCD6,
                    thickness: 0.5,
                  ),
                  CupertinoButton(
                      child: TextWidget(
                          text: 'Save'.tr,
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_65AF7C),
                      onPressed: () {
                        if (_inputC.text.isNotEmpty) {
                          widget.onValueUpdated?.call(_inputC.text);
                          Get.back(result: _inputC.text);
                        }
                      }),
                ],
              ),
            ).padding(horizontal: 30.w)
          ],
        ),
      ),
    );
  }
}
