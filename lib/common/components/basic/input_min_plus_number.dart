// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class InputMinPlusNumber extends StatelessWidget {
  InputMinPlusNumber({
    super.key,
    required this.title,
    required this.height,
    // required this.decoration,
    int number = 1,
  }) {
    this.number.value = number;
  }
  final String title;
  final double height;
  // final BoxDecoration decoration;

  var number = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: number.value == 0
                  ? AppColors.color_C5C5C5
                  : AppColors.color_1A342B), // 设置边框宽度为2px
          borderRadius: BorderRadius.circular(height), // 设置边框圆角
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // 水平居中对齐
          // textBaseline: TextBaseline.ideographic, // 或者 TextBaseline.ideographic
          children: [
            TextWidget(
            text:   title, // 左边的文字
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  color: number.value == 0
                      ? AppColors.color_C5C5C5
                      : AppColors.color_1A342B,
                  fontSize: 14.sp
              )

            ),
            number.value == 0
                ? InkWell(
                    onTap: () {
                      number.value++;
                    },
                    child: IconWidget.svg(
                      size: 16.w,
                      'assets/svg/logadd.svg',
                    ).paddingOnly(right: 15),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center, // 水平居中对齐
                    children: [
                      InkWell(
                        onTap: () {
                          number.value--;
                        },
                        child: IconWidget.svg(
                          size: 16,
                          'assets/svg/ico_min.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${number.value}', // 数字
                        style: const TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            color: AppColors.color_1A342B,
                            fontSize: 12), // 设置文字大小
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          number.value++;
                        },
                        child: IconWidget.svg(
                          size: 16,
                          'assets/svg/ico_plus.svg',
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
