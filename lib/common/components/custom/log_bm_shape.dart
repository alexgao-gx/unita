import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/extension/ex_widget.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

import '../../style/colors.dart';
import '../../widgets/icon.dart';
import '../../widgets/text.dart';
import '../basic/slider_text.dart';

class LogBmShapeWidget extends StatefulWidget {
  const LogBmShapeWidget(
      {super.key, this.onShapeChanged, this.shapes, this.shapeIcons});
  final List<EnumModel>? shapes;
  final List<String>? shapeIcons;
  final void Function(EnumModel shape, int shapeIndex)? onShapeChanged;

  @override
  State<LogBmShapeWidget> createState() => _LogBmShapeWidgetState();
}

class _LogBmShapeWidgetState extends State<LogBmShapeWidget> {
  late PageController pageController;
  List<EnumModel> get shapes => widget.shapes ?? <EnumModel>[];
  List<String> get shapeIcons => widget.shapeIcons ?? <String>[];
  int get _pageIndex => max(0, shapes.indexWhere((e) => e.isSelected.value == true));

  @override
  void initState() {
    pageController =
        PageController(initialPage: _pageIndex, viewportFraction: 0.5);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LogBmShapeWidget oldWidget) {
    pageController.jumpToPage(_pageIndex);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextWidget(
          text: 'What does your poop look like?'.tr,
          size: 16.sp,
          weight: FontWeight.w500,
          color: AppColors.color_1A342B,
        ).paddingHorizontal(14.w),
        43.verticalSpace,
        SizedBox(
          height: 70.h,
          child: PageView.builder(
              onPageChanged: (index) {
                for (int i = 0; i < shapes.length; i++) {
                  shapes[i].isSelected.value = index == i;
                }
                setState(() {});
                widget.onShapeChanged?.call(shapes[index], index);
              },
              itemCount: shapes.length,
              controller: pageController,
              itemBuilder: ((context, index) {
                return UnconstrainedBox(
                  constrainedAxis: Axis.vertical,
                  child: IconWidget.svg(
                    _pageIndex == index
                        ? shapeIcons[index]
                        : shapeIcons[index].replaceAll('sel', 'nor'),
                    width: _pageIndex == index ? 127.w : 81.w,
                    height: _pageIndex == index ? 80.h : 42.h,
                    fit: BoxFit.fill,
                  ),
                );
              })),
        ),
        34.verticalSpace,
        TextWidget(
          text: shapes.isNotEmpty ? shapes[_pageIndex].text ?? '' : '',
          style: GoogleFonts.openSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.color_456C51,
          ),
        ).center(),
        const SizedBox(
          height: 15,
        ),
        SliderTextWidget(
          datas: shapes,
          showSliderText: false,
          onValueChanged: (v) {
            pageController.jumpToPage(_pageIndex);
            setState(() {});
          },
        ),
      ],
    );
  }
}
