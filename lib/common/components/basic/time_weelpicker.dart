import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:wheel_picker/wheel_picker.dart';

class TimeWheelPicker extends StatefulWidget {
  TimeWheelPicker(
      {key,
      required this.list1,
      required this.split,
      required this.list2,
      required this.list3,
      this.initialIndex1 = 3,
      this.initialIndex2 = 3,
      this.initialIndex3 = 0,
      this.onValueChanged})
      : super(key: key);

  final List<String> list1;
  final String split;
  final List<String> list2;
  final List<String> list3;

  final void Function({int? index1, int? index2, int? index3})? onValueChanged;
  final int? initialIndex1;
  final int? initialIndex2;
  final int? initialIndex3;

  @override
  State<TimeWheelPicker> createState() => _TimeWheelPickerState();
}

class _TimeWheelPickerState extends State<TimeWheelPicker> {
  int? _index1 = 3;
  int? _index2 = 3;
  int? _index3 = 0;

  @override
  void initState() {
    _index1 = widget.initialIndex1;
    _index2 = widget.initialIndex2;
    _index3 = widget.initialIndex3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.fahkwang(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.color_65AF7C,
    );
    TextStyle unselectedTextStyle = GoogleFonts.fahkwang(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.color_C5C5C5,
    );
    WheelPickerStyle wheelStyle = const WheelPickerStyle(
      size: 248,
      itemExtent: 82,
      squeeze: 1.5,
      diameterRatio: 4,
      surroundingOpacity: 0.8,
      magnification: 1,
    );

    // Widget itemBuilder(BuildContext context, int index) {
    //   return Text("$index".padLeft(2, '0'),
    //       style: textStyle); //.paddingOnly(top: 14, bottom: 14)
    // }
    widget.onValueChanged
        ?.call(index1: _index1, index2: _index2, index3: _index3);
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
                itemCount: widget.list1.length,
                builder: (context, index) {
                  return Text(widget.list1[index],
                          style: index == _index1
                              ? textStyle
                              : unselectedTextStyle)
                      .paddingOnly(top: 34, left: 7);
                },
                initialIndex: widget.initialIndex1,
                looping: false,
                style: wheelStyle.copyWith(
                    shiftAnimationStyle: const WheelShiftAnimationStyle(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                )),
                onIndexChanged: (v) {
                  _index1 = v;
                  widget.onValueChanged
                      ?.call(index1: _index1, index2: _index2, index3: _index3);
                  setState(() {});
                },
              ),
              Text(widget.split, style: textStyle).alignCenter(),
              WheelPicker(
                itemCount: widget.list2.length,
                builder: (context, index) {
                  return Text(widget.list2[index],
                          style: index == _index2
                              ? textStyle
                              : unselectedTextStyle)
                      .paddingOnly(top: 34, left: 7);
                },
                initialIndex: widget.initialIndex2,
                looping: false,
                style: wheelStyle.copyWith(
                    shiftAnimationStyle: const WheelShiftAnimationStyle(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                )),
                onIndexChanged: (v) {
                  _index2 = v;
                  widget.onValueChanged
                      ?.call(index1: _index1, index2: _index2, index3: _index3);
                  setState(() {});
                },
              ),
              if (widget.list3.isNotEmpty)
                WheelPicker(
                  itemCount: widget.list3.length,
                  builder: (context, index) {
                    return Text(widget.list3[index],
                            style: index == _index3
                                ? textStyle
                                : unselectedTextStyle)
                        .paddingOnly(top: 34, left: 7);
                  },
                  initialIndex: widget.initialIndex3,
                  looping: false,
                  style: wheelStyle.copyWith(
                      shiftAnimationStyle: const WheelShiftAnimationStyle(
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceOut,
                  )),
                  onIndexChanged: (v) {
                    _index3 = v;
                    widget.onValueChanged?.call(
                        index1: _index1, index2: _index2, index3: _index3);
                    setState(() {});
                  },
                ),
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
        height: 41.h,
        decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal:
                  BorderSide(color: AppColors.color_E6DCD6, width: 0.5)),
        ),
      ),
    );
  }
}
