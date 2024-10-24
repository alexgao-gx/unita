import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unitaapp/common/index.dart';

class MeSettingItem extends StatelessWidget {
  const MeSettingItem({
    super.key,
    required this.iconName,
    required this.title,
    required this.arrow,
    required this.onTap,
    this.iconSize,
  });
  final String iconName;
  final String title;
  final String arrow;
  final Function onTap;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 52.h,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconWidget.svg(iconName, size:iconSize ?? 20.r),
                    SizedBox(
                      width: 10.w
                    ),
                    TextWidget(
                      text: title,
                      size: 16.sp,
                      weight: FontWeight.w600,
                      color: AppColors.color_1A342B,
                    ),
                  ],
                ).center(),
                IconWidget.svg(
                  arrow,
                  width: 7,
                  height: 12,
                ),
              ],
            ),
            const Divider(
              //then this defaults to 16.0.
              height: 1,
            ).alignBottom(),
          ],
        ),
      ),
    );
  }
}
