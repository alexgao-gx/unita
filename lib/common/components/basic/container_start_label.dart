import 'package:flutter/material.dart';
import 'package:unitaapp/common/index.dart';

class ContainerStartLabel extends StatelessWidget {
  const ContainerStartLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Container(
            width: 114,
            height: 114,
            decoration: BoxDecoration(
              border: Border.all(
                width: 6,
                color: AppColors.color_F3F7ED,
              ),
              borderRadius: BorderRadius.circular(57),
            ),
          ).center(),
          const SizedBox(
            width: 110,
            height: 110,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: AppColors.color_65AF7C,
              value: 0.5,
            ),
          ).center(),
          const TextWidget(
            text: '00:21',
            size: 16,
            weight: FontWeight.w500,
            color: AppColors.color_1A342B,
          ).center(),
        ],
      ),
    );
  }
}
