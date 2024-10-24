// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:unitaapp/common/index.dart';

import 'package:unitaapp/common/style/colors.dart';

class ContainerTextButton extends StatelessWidget {
  const ContainerTextButton({
    super.key,
    required this.tapAction,
    required this.bgColor,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.text,
    required this.textSize,
    required this.textWeight,
    required this.textColor,
  });
  final Function() tapAction;
  final Color bgColor;
  final double width;
  final double height;
  final double borderRadius;
  final String text;
  final double textSize;
  final FontWeight textWeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor, // 设置背景色
        borderRadius: BorderRadius.circular(borderRadius), // 设置圆角
      ),
      child: TextButton(
        onPressed: () {
          tapAction();
        },
        child: TextWidget(
          text: text,
          weight: textWeight,
          color: textColor,
          size: textSize,
        ),
      ),
    );
  }
}
