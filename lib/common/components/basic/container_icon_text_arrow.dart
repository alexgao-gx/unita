import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unitaapp/common/index.dart';

class ContainerIconTextArrow extends StatelessWidget {
  const ContainerIconTextArrow(
      {super.key,
      required this.iconName,
      required this.title,
      required this.arrow});
  final String iconName;
  final String title;
  final String arrow;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.color_1A342B),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          IconWidget.svg(
            iconName,
            width: 14,
            height: 14,
          ),
          const SizedBox(
            width: 5,
          ),
          TextWidget(
            text: title,
            size: 12,
            weight: FontWeight.w400,
            color: AppColors.color_1A342B,
          ),
          const SizedBox(
            width: 5,
          ),
          IconWidget.svg(
            arrow,
            width: 5,
            height: 9,
          ),
        ],
      ),
    );
  }
}
