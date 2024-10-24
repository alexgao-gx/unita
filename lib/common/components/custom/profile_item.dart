import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unitaapp/common/index.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.arrow,
    required this.onTap,
    this.isHideSubTitle = false,
    this.isHideArrow = false,
    this.height,
    this.titleTextSize,
  });
  final String subTitle;
  final String title;
  final String arrow;
  final Function onTap;
  bool isHideSubTitle;
  bool isHideArrow;
  final double? height;
  final double? titleTextSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height:height?? 42.h,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: title,
                  size:titleTextSize?? 14.sp,
                  weight: FontWeight.w600,
                  color: AppColors.color_1A342B,
                ),
                Row(
                  children: [
                    if (!isHideSubTitle)
                      TextWidget(
                        text: subTitle,
                        size: 12.sp,
                        weight: FontWeight.w400,
                        color: AppColors.color_1A342B,
                      ),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (!isHideArrow)
                      IconWidget.svg(
                        arrow,
                        width: 7,
                        height: 12,
                      ),
                  ],
                ),
              ],
            ).center(),
            const Divider(
              height: 1,
            ).alignBottom(),
          ],
        ),
      ),
    );
  }
}
