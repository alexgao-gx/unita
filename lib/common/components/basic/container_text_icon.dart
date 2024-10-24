import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class ContainerTextIcon extends StatelessWidget {
  const ContainerTextIcon(
      {super.key,
      required this.goDetail,
      required this.svgPath,
      required this.title,
      required this.backgroundColor,
      required this.height,
      required this.width});
  final Function() goDetail;
  final String svgPath;
  final String title;
  final Color backgroundColor;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goDetail();
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8.0), // 设置容器的内边距
        decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.color_1A342B, width: 1), // 设置容器的边框
          borderRadius: BorderRadius.circular(44.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextWidget(
               text:  title,
                size: 16,
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,

              ),
              const SizedBox(width: 10.0),
              // 左边的图标
              IconWidget.svg(
                width: 20,
                height: 9,
                svgPath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
