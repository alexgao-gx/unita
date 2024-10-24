// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';

import 'package:unitaapp/common/style/colors.dart';

class ContainerText extends StatelessWidget {
  ContainerText({
    super.key,
    required this.tapAction,
    required this.bgColor,
     this.width,
     this.height,
    required this.borderRadius,
    required this.text,
    required this.textSize,
    required this.textWeight,
    required this.textColor,
    this.borderColor,
    this.subTitle,
    this.alignment,
    this.textAlign,
    this.borderWidth = 1,
    this.verPadding,
    this.horPadding = 24,
  });
  final Function() tapAction;
  final Color bgColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final String text;
  final double textSize;
  final FontWeight textWeight;
  final Color textColor;
  final Widget? subTitle;
  final Color? borderColor;
  final Alignment? alignment;
  final TextAlign? textAlign;
  double borderWidth = 1;
 final double? verPadding;
  double horPadding = 24;


  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: height ?? 56.h,
      onPressed: tapAction,
      alignment:alignment ?? Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horPadding, vertical: verPadding ?? 0),
        alignment:alignment ?? Alignment.centerLeft,
        width: width,
        height: height,
        constraints: BoxConstraints(minHeight:height ??  56.h),
        // height: verPadding != null ? null :( height ?? 56),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppColors.color_C5C5C5, width: borderWidth),
          color: bgColor, // 设置背景色
          borderRadius: BorderRadius.circular(borderRadius), // 设置圆角
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              textAlign:textAlign ?? TextAlign.left,
              text: text,
              weight: textWeight,
              color: textColor,
              size: textSize,
              maxLines: null,
              softWrap: true,
            ),
            subTitle ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
