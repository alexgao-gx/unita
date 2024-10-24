import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/input_min_plus_number.dart';
import 'package:unitaapp/common/index.dart';

class ScanFoodListSave extends StatelessWidget {
  const ScanFoodListSave(
      {super.key,
      required this.height,
      required this.list,
      required this.onClose,
      required this.onSave});
  final double height;
  final List list;
  final Function() onClose;
  final Function() onSave;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 19),
      height: height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Scanned Food'.tr,
                color: AppColors.color_1A342B,
                size: 16.sp,
                weight: FontWeight.w500,
              ),
              InkWell(
                onTap: onClose,
                child: IconWidget.image(
                  'assets/images/icon_close.png',
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    const Divider(
                      height: 1,
                      color: AppColors.color_C1E1CE,
                    ),
                    InputMinPlusNumber(
                      title: list[index],
                      height: 55,
                    )
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Total: count ingredients'.trArgs(['${list.length}'])
                ,
                softWrap: true,
                maxLines: null,
                size: 16.sp,
                color: AppColors.color_1A342B,
                weight: FontWeight.w600,
              ),
              ButtonWidget.text(
                width: 139.w,
                height: 40.h,
                'Save'.tr,
                backgroundColor: AppColors.color_65AF7C,
                borderRadius: 8.w,
                textColor: AppColors.color_FCF8F1,
                textSize: 16.sp,
                textWeight: FontWeight.w600,
                onTap: () {
                  onSave();
                  print('save');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
