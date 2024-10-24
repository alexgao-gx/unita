import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/diet_model.dart';
import 'package:unitaapp/common/widgets/index.dart';

class DietItem extends StatelessWidget {
  const DietItem({super.key, required this.model});
  final DietModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      // height: 428,
      decoration: BoxDecoration(
        color: AppColors.color_F3F7ED,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 86,
            decoration: BoxDecoration(
              color: AppColors.color_C1E1CE,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ImageWidget.asset(
                  'assets/images/${model.imageName}.png',
                  width: 86,
                  height: 86,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: model.title,
                      size: 20,
                      weight: FontWeight.w700,
                      color: AppColors.color_1A342B,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //  TextWidget(text: model.description),
                    ContainerTextButton(
                      tapAction: () {},
                      bgColor: AppColors.color_F3F7ED,
                      width: 97,
                      height: 29,
                      borderRadius: 16,
                      text: model.description,
                      textSize: 12,
                      textWeight: FontWeight.w400,
                      textColor: AppColors.color_1A342B,
                    )
                  ],
                ).paddingSymmetric(vertical: 10),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextWidget(
            text: model.subTitle,
            weight: FontWeight.w500,
            color: AppColors.color_1A342B,
            size: 16,
          ).paddingLeft(22),
          const SizedBox(
            height: 9,
          ),
          TextWidget(
            softWrap: true,
            maxLines: null,
            weight: FontWeight.w400,
            color: AppColors.color_1A342B,
            size: 12,
            text: model.subDescription,
          ).paddingSymmetric(horizontal: 22),
          const Divider(
            height: 1,
            color: AppColors.color_E6DCD6,
          ).paddingSymmetric(horizontal: 22, vertical: 26),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: model.title1,
                        size: 12,
                        color: AppColors.color_456C51,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      TextWidget(
                        softWrap: true,
                        maxLines: null,
                        text: model.description1,
                        size: 14,
                        color: AppColors.color_1A342B,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 0.5,
                  height: 45,
                  color: AppColors.color_E6DCD6,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: model.title2,
                        size: 12,
                        color: AppColors.color_456C51,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      TextWidget(
                        softWrap: true,
                        maxLines: null,
                        text: model.description2,
                        size: 14,
                        color: AppColors.color_1A342B,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ).center(),
                ),
                Container(
                  width: 0.5,
                  height: 45,
                  color: AppColors.color_E6DCD6,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: model.title3,
                        size: 12,
                        color: AppColors.color_456C51,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      TextWidget(
                        softWrap: true,
                        maxLines: null,
                        text: model.description3,
                        size: 14,
                        color: AppColors.color_1A342B,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ).center(),
                ),
              ],
            ).paddingSymmetric(horizontal: 22),
          ),
          const Divider(
            height: 1,
            color: AppColors.color_E6DCD6,
          ).paddingSymmetric(horizontal: 22, vertical: 6),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextWidget(
                text: 'Expand All Info'.tr,
                size: 14,
                color: AppColors.color_65AF7C,
                weight: FontWeight.w600,
              ),
              const SizedBox(
                width: 2,
              ),
              IconWidget.svg(
                'assets/svg/downarrow.svg',
                width: 7,
                height: 12,
              ),
            ],
          ).center(),
          const SizedBox(
            height: 17,
          ),
        ],
      ),
    );
  }
}
