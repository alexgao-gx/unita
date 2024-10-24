import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/widgets/index.dart';
import 'package:wheel_picker/wheel_picker.dart';

class CustomWeelPicker extends StatelessWidget {
  CustomWeelPicker(
      {super.key,
      required this.list1,
      required this.split,
      required this.list2,
      required this.list3,
      this.initialIndex1 = 3,
      this.initialIndex2 = 3,
      this.initialIndex3 = 0,
      this.onValueChanged})
      : _index1 = initialIndex1,
        _index2 = initialIndex2,
        _index3 = initialIndex3;

  var list1 = [];
  var split = '';
  var list2 = [];
  var list3 = [];

  final void Function({int? index1, int? index2, int? index3})? onValueChanged;
  final int? initialIndex1;
  final int? initialIndex2;
  final int? initialIndex3;

  int? _index1 = 3;
  int? _index2 = 3;
  int? _index3 = 0;

  @override
  Widget build(BuildContext context) {
    WheelPickerStyle wheelStyle = const WheelPickerStyle(
      size: 248,
      itemExtent: 86,
      squeeze: 1.4,
      diameterRatio: 1.4,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    // Widget itemBuilder(BuildContext context, int index) {
    //   return Text("$index".padLeft(2, '0'),
    //       style: textStyle); //.paddingOnly(top: 14, bottom: 14)
    // }
    onValueChanged?.call(index1: _index1, index2: _index2, index3: _index3);
    return SizedBox(
      height: 248,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _centerBar(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WheelPicker(
                itemCount: list1.length,
                builder: (context, index) {
                  return TextWidget(
                          text: list1[index],
                          color: AppColors.color_1A342B,
                          size: 18.sp,
                          weight: FontWeight.w600)
                      .alignCenter();
                },
                initialIndex: initialIndex1,
                looping: false,
                style: wheelStyle.copyWith(
                    shiftAnimationStyle: const WheelShiftAnimationStyle(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                )),
                onIndexChanged: (v) {
                  _index1 = v;
                  onValueChanged?.call(
                      index1: _index1, index2: _index2, index3: _index3);
                },
              ).expanded(),
              TextWidget(
                text: split,
                size: 18.sp,
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,
              ).alignCenter(),
              WheelPicker(
                itemCount: list2.length,
                builder: (context, index) {
                  return TextWidget(
                          text: list2[index],
                          size: 18.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_1A342B)
                      .alignCenter();
                },
                initialIndex: initialIndex2,
                looping: false,
                style: wheelStyle.copyWith(
                    shiftAnimationStyle: const WheelShiftAnimationStyle(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                )),
                onIndexChanged: (v) {
                  _index2 = v;
                  onValueChanged?.call(
                      index1: _index1, index2: _index2, index3: _index3);
                },
              ).expanded(),
              if (list3.isNotEmpty)
                WheelPicker(
                  itemCount: list3.length,
                  builder: (context, index) {
                    return TextWidget(
                            text: list3[index],
                            size: 18.sp,
                            weight: FontWeight.w600,
                            color: AppColors.color_1A342B)
                        .alignCenter();
                  },
                  initialIndex: initialIndex3,
                  looping: false,
                  style: wheelStyle.copyWith(
                      shiftAnimationStyle: const WheelShiftAnimationStyle(
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceOut,
                  )),
                  onIndexChanged: (v) {
                    _index3 = v;
                    onValueChanged?.call(
                        index1: _index1, index2: _index2, index3: _index3);
                  },
                ).expanded(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _centerBar(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.color_C1E1CE,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
