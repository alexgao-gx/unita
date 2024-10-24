import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/index.dart';

import '../../models/log_model.dart';
import '../../style/colors.dart';
import '../../widgets/text.dart';

class LogWorkoutCounterWidget extends StatefulWidget {
  const LogWorkoutCounterWidget(
      {super.key,
      required this.workout,
      required this.workoutIconName,
      this.onRemove,
      this.onSaved});

  final Workout workout;
  final String workoutIconName;
  final VoidCallback? onRemove;
  final ValueChanged<double>? onSaved;

  @override
  State<LogWorkoutCounterWidget> createState() =>
      _LogWorkoutCounterWidgetState();
}

class _LogWorkoutCounterWidgetState extends State<LogWorkoutCounterWidget> {
  double _hours = 0.5;

  @override
  void initState() {
    final initialHours = double.tryParse(widget.workout.hours ?? '0') ?? 0.5;
    _hours = initialHours > 0.5 ? initialHours : 0.5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 511.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned.fill(
                top: 12.h,
                child: TextWidget(
                  text: 'Edit Workout'.tr,
                  size: 18.sp,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w700,
                  color: AppColors.color_1A342B,
                ),
              ),
              Row(
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.only(
                          left: 0, top: 15.h, bottom: 15.h, right: 20.w),
                      child: TextWidget(
                        color: AppColors.color_C5C5C5,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        text: 'Cancel'.tr,
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.5,
            color: AppColors.color_E6DCD6,
          ),
          20.verticalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWorkoutInfo(),
                Divider(height: 50.h),
                _buildCounter(),
                16.verticalSpace,
                TextWidget(
                  text: 'hour'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.color_1A342B,
                  ),
                ),
                38.verticalSpace,
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 44,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(
                                  side: BorderSide(
                                      color: AppColors.color_1A342B,
                                      width: 0.5)),
                            ),
                            child: TextWidget(
                              text: 'Remove'.tr,
                              weight: FontWeight.w600,
                              color: AppColors.color_1A342B,
                              size: 16.sp,
                            ),
                            onPressed: () {
                              widget.onRemove?.call();
                              Get.back();
                            },
                          ),
                        )),
                    8.horizontalSpace,
                    Expanded(
                        flex: 4,
                        child: ContainerTextButton(
                          tapAction: () {
                            widget.onSaved?.call(_hours);
                            Get.back();
                          },
                          bgColor: AppColors.color_65AF7C,
                          borderRadius: 44.h,
                          height: 44,
                          text: 'Save'.tr,
                          textWeight: FontWeight.w600,
                          textColor: AppColors.color_FCF8F1,
                          textSize: 16.sp,
                          width: double.infinity,
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkoutInfo() {
    return Row(
      children: [
        27.horizontalSpace,
        IconWidget.svg(
          size: 50.w,
          color: AppColors.color_1A342B,
          'assets/svg/${widget.workoutIconName}',
        ),
        12.horizontalSpace,
        Expanded(
            child: TextWidget(
          text: '${widget.workout.name}',
          size: 16.sp,
          weight: FontWeight.w600,
          color: AppColors.color_1A342B,
        )),
      ],
    );
  }

  Widget _buildCounter() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
              child: IconWidget.svg(
                size: 30.w,
                color: AppColors.color_1A342B,
                'assets/svg/ico_min.svg',
              ),
              onPressed: () {
                if (_hours > 0.5) {
                  setState(() {
                    _hours -= 0.5;
                  });
                }
              }),
          40.horizontalSpace,
          Container(
            width: 120.w,
            height: 120.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/homescorebg.png')),
            ),
            child: Center(
              child: TextWidget(
                text: '$_hours',
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,
                size: 36.sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          40.horizontalSpace,
          CupertinoButton(
              child: IconWidget.svg(
                size: 30.w,
                color: AppColors.color_1A342B,
                'assets/svg/ico_plus.svg',
              ),
              onPressed: () {
                setState(() {
                  _hours += 0.5;
                });
              }),
        ],
      );
}
