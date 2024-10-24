import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class ContainerIconText extends StatelessWidget {
  const ContainerIconText(
      {super.key,
      required this.goDetail,
      required this.svgPath,
      required this.title,
      required this.backgroundColor});
  final Function() goDetail;
  final String svgPath;
  final String title;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goDetail();
      },
      child: Container(
        height: 51,
        padding: const EdgeInsets.all(8.0), // 设置容器的内边距
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // 设置容器的边框
          borderRadius: BorderRadius.circular(8.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 左边的图标
              IconWidget.svg(
                svgPath,
              ),
              const SizedBox(width: 3.0), // 添加一些水平间距
              // 右边的文本
              Text(
                title,
                style: const TextStyle(
                    fontFamily: '',
                    fontWeight: FontWeight.w600,
                    color: AppColors.color_456C51,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
