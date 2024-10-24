import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

import '../../widgets/text.dart';

AppBar appBar(
    {String? title,
    Widget? titleWidget,
    List<Widget>? actions,
    double? elevation,
    bool showLeading = true, Color? backgroundColor}) {
  return AppBar(
    backgroundColor:backgroundColor,
    centerTitle: true,
    elevation: elevation ?? 0.1,
    // 左边的文本
    leading: showLeading
        ? SizedBox(
            width: 30, // 按钮宽度
            height: 30, // 按钮高度
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: IconWidget.svg(
                'assets/svg/ico_back.svg',
                width: 10.w,
                height: 16.h,
              ),
            ),
          )
        : SizedBox.shrink(),
    // 中间的文本
    title: titleWidget ??
        Text(
          title ?? '',
          style: GoogleFonts.fahkwang(
              fontWeight: FontWeight.w700,
              color: AppColors.color_1A342B,
              fontSize: 20.sp),
        ),
    actions: actions,
  );
}

AppBar logAppBar({String? title, double? titleFontSize, String? logActionText, VoidCallback? onSave}) {
  return AppBar(
    elevation: 0.1,
    leadingWidth: 80.w,
    centerTitle: true,
    leading: CupertinoButton(
      padding: EdgeInsets.only(left: 10.w),
      onPressed: () => Get.back(),
      alignment: Alignment.centerLeft,
      child: TextWidget(
        text: 'Cancel'.tr,
        weight: FontWeight.w400,
        color: AppColors.color_1A342B,
        size: 14.sp,
      ),
    ),
    title: TextWidget(
        text: title ?? '',
        weight: FontWeight.w600,
        color: AppColors.color_1A342B,
        size:titleFontSize ?? 17),
    actions: [
      CupertinoButton(
          onPressed: onSave,
          child: TextWidget(
              text: logActionText ?? "Save All".tr,
              weight: FontWeight.w400,
              color: AppColors.color_1A342B,
              size: 14.sp))
    ],
  );
}
