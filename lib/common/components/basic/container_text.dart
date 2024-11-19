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
    this.maxLines = 1, // Default maxLines to 1 for text overflow handling
    this.overflow = TextOverflow.ellipsis, // Default overflow behavior
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
  final double borderWidth;
  final double? verPadding;
  final double horPadding;
  final int maxLines; // New property for controlling text lines
  final TextOverflow overflow; // New property for handling text overflow

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: height ?? 56.h,
      onPressed: tapAction,
      alignment: alignment ?? Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horPadding,
          vertical: verPadding ?? 0,
        ),
        alignment: alignment ?? Alignment.centerLeft,
        width: width,
        height: height,
        constraints: BoxConstraints(minHeight: height ?? 56.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? AppColors.color_C5C5C5,
            width: borderWidth,
          ),
          color: bgColor, // Background color
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              textAlign: textAlign ?? TextAlign.left,
              text: text,
              weight: textWeight,
              color: textColor,
              size: textSize,
              maxLines: maxLines, // Max lines for text
              overflow: overflow, // Handle text overflow
              softWrap: true,
            ),
            subTitle ?? SizedBox.shrink(), // Optional subtitle
          ],
        ),
      ),
    );
  }
}
