import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unitaapp/common/components/custom/water_tip.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class DrinkTipsGridView extends StatelessWidget {
  const DrinkTipsGridView({
    super.key,
    required this.listGrass,
    required this.title,
    required this.subTitle,
    this.targetValue,
    required this.description,
    required this.icon,
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
  });
  final List<String> listGrass;
  final String title;
  final String subTitle;
  final String? targetValue;
  final String description;
  final String icon;
  final int crossAxisCount; // 每行6个图标
  final double mainAxisSpacing; // 主轴间距
  final double crossAxisSpacing; //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WaterTip(
          title: title,
          subTitle: subTitle,
          targetValue: targetValue,
          icon: icon,
          description: description,
        ),
        11.verticalSpace,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: AppColors.color_F3F7ED,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Obx(() => GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(20.w),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // 每行6个图标
                  mainAxisSpacing: mainAxisSpacing, // 主轴间距
                  crossAxisSpacing: crossAxisSpacing, // 交叉轴间距
                  childAspectRatio: 1,
                ),
                itemCount: min(max(listGrass.length, 16), 16),
                itemBuilder: (BuildContext context, int index) {
                  String imageName;
                  if (index < listGrass.length) {
                    imageName = listGrass[index];
                  } else {
                    imageName = 'ico_water_nor.svg';
                  }
                  return IconWidget.svg(
                    size: 30.w,
                    'assets/svg/$imageName',
                  ); // 这里使用一个示例图标，您可以替换为您想要的图标
                },
              )),
        ),
      ],
    );
  }
}
