import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class IconInputMinPlusNumber extends StatelessWidget {
  IconInputMinPlusNumber(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});
  final String title;
  final String subtitle;
  final String icon;

  var number = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: number.value == 0 ? 48 : 65,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: number.value == 0
                  ? AppColors.color_C5C5C5
                  : AppColors.color_456C51), // 设置边框宽度为2px
          borderRadius: BorderRadius.circular(8.0), // 设置边框圆角
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // 水平居中对齐
          // textBaseline: TextBaseline.ideographic, // 或者 TextBaseline.ideographic
          children: [
            Row(
              children: [
                SizedBox(
                    width: 26,
                    height: 26,
                    child: IconWidget.svg(
                        'assets/svg/${number.value != 0 ? icon : icon.replaceAll('sel', 'nor')}')),
                const SizedBox(
                  width: 5,
                ),
                subtitle.isEmpty
                    ? Center(
                        child: Text(
                          title, // 左边的文字
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w600,
                              color: number.value == 0
                                  ? AppColors.color_C5C5C5
                                  : AppColors.color_456C51,
                              fontSize: 16), // 设置文字大小
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title, // 左边的文字
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                color: AppColors.color_456C51,
                                fontSize: 12), // 设置文字大小
                          ),
                          Text(
                            subtitle, // 左边的文字
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                color: AppColors.color_456C51,
                                fontSize: 12), // 设置文字大小
                          ),
                        ],
                      )
              ],
            ),
            Container(
              child: number.value == 0
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
                            size: 16.w,
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
                              size: 16.w,
                              'assets/svg/ico_plus.svg',
                            )),
                      ],
                    ),
            ),
          ],
        ),
      );
    });
  }
}
