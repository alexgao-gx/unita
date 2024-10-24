import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/slider_text.dart';
import 'package:unitaapp/common/extension/ex_widget.dart';

import '../../models/signup_flow_model.dart';
import '../../style/colors.dart';
import '../../widgets/icon.dart';
import '../../widgets/text.dart';

class LogMoodWidget extends StatefulWidget {
  const LogMoodWidget({super.key, this.moods, this.onMoodChanged});
  final void Function(EnumModel mood, int moodIndex)? onMoodChanged;
  final List<EnumModel>? moods;

  @override
  State<LogMoodWidget> createState() => _LogMoodWidgetState();
}

class _LogMoodWidgetState extends State<LogMoodWidget> {
  List<String> _moodImageList = [
    'assets/svg/img_VeryUnpleasant.svg',
    'assets/svg/img_Unpleasant.svg',
    'assets/svg/img_Neutral.svg',
    'assets/svg/img_Pleasant.svg',
    'assets/svg/img_VeryPleasant.svg',
  ];

  int _index = 0;

  @override
  void initState() {
    (widget.moods ?? []).forEach((e) {
      if (e.isSelected.value == true) {
        _index = widget.moods!.indexOf(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          border: Border(
              bottom: BorderSide(color: AppColors.color_A7998F, width: 0.5))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Mood:'.tr,
                        size: 16.sp,
                        weight: FontWeight.w500,
                        color: AppColors.color_1A342B,
                      ),
                      36.verticalSpace,
                      // 气泡
                      CustomPaint(
                        painter: MoodBubblePainter(radius: 10.r),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(13.w, 10.h, 23.w, 9.h),
                          // width: 133.w,
                          // height: 63.h,
                          child: TextWidget(
                            text: 'I’m feeling'.trArgs([((widget.moods?.isNotEmpty == true) ? widget.moods![_index].text ?? '' : 'Neutral.')]),
                            size: 18.sp,
                            weight: FontWeight.w700,
                            color: AppColors.color_1A342B,
                            softWrap: true,
                            maxLines: 3,
                            textAlign: TextAlign.start,
                          ).center(),
                        ),
                      )
                    ],
                  ).paddingOnly(left: 14.w)),
              Expanded(
                  flex: 4,
                  child: IconWidget.svg(
                    _moodImageList[_index],
                    height: 216.h,
                    width: 228.w,
                  ))
            ],
          ),
          const Divider(height: 0.5),
          29.verticalSpace,
          SliderTextWidget(
            datas: widget.moods,
            onValueChanged: (data) {
              setState(() {
                _index =
                    widget.moods?.indexWhere((e) => e.value == data.value) ?? 0;
              });
              widget.onMoodChanged?.call(data, _index);
            },
          ),
          48.verticalSpace,
        ],
      ),
    );
  }
}

class MoodBubblePainter extends CustomPainter {

  final bool? isArrowOnLeft; // 控制箭头是否在左侧
  final double radius; // 圆角半径
  final Color? bubbleColor; // 气泡颜色
  final double? arrowCenterY;

  MoodBubblePainter({
     this.isArrowOnLeft = false,
    required this.radius,
     this.bubbleColor,
    this.arrowCenterY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bubbleColor ?? AppColors.color_C1E1CE
      ..style = PaintingStyle.fill;

    final path = Path();
    final arrowCenterYValue = arrowCenterY ?? size.height / 2;

    if (isArrowOnLeft == true) {
      // 箭头在左侧
      path.moveTo(10 + radius, 0); // 顶部开始点，避开箭头
      path.lineTo(size.width - radius, 0); // 顶部直线
      path.arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius)); // 右上角圆角
      path.lineTo(size.width, size.height - radius); // 右侧直线
      path.arcToPoint(Offset(size.width - radius, size.height), radius: Radius.circular(radius)); // 右下角圆角
      path.lineTo(10 + radius, size.height); // 底部直线
      path.arcToPoint(Offset(10, size.height - radius), radius: Radius.circular(radius)); // 左下角圆角
      path.lineTo(10, arrowCenterYValue + 8); // 左侧箭头下部分
      path.lineTo(0, arrowCenterYValue); // 箭头尖
      path.lineTo(10, arrowCenterYValue - 8); // 左侧箭头上部分
      path.lineTo(10, radius); // 左侧直线到上圆角
      path.arcToPoint(Offset(10 + radius, 0), radius: Radius.circular(radius)); // 左上角圆角
    } else {
      // 箭头在右侧
      path.moveTo(0, radius); // 左上角
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius)); // 左上圆角
      path.lineTo(size.width - 10 - radius, 0); // 顶部
      path.arcToPoint(Offset(size.width - 10, radius), radius: Radius.circular(radius)); // 右上圆角
      path.lineTo(size.width - 10, arrowCenterYValue - 8); // 箭头上顶点
      path.lineTo(size.width, arrowCenterYValue); // 箭头尖
      path.lineTo(size.width - 10, arrowCenterYValue + 8); // 箭头下顶点
      path.lineTo(size.width - 10, size.height - radius); // 右下角
      path.arcToPoint(Offset(size.width - 10 - radius, size.height), radius: Radius.circular(radius)); // 右下圆角
      path.lineTo(radius, size.height); // 底部
      path.arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius)); // 左下圆角
      path.lineTo(0, radius); // 左侧
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
