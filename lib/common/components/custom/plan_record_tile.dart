import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

import '../../widgets/icon.dart';

class PlanRecordTile extends StatelessWidget {
  const PlanRecordTile(
      {super.key,
      required this.svgPath,
      required this.tileName,
      required this.child});
  final String svgPath;
  final String tileName;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconWidget.svg(
              size: 22.w,
              svgPath,
            ),
            5.horizontalSpace,
            Expanded(
                child: TextWidget(
              text: tileName,
              style: GoogleFonts.openSans(
                  color: AppColors.color_1A342B,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ))
          ],
        ),
        15.verticalSpace,
        IntrinsicHeight(
          child: Row(
            children: [
              VerticalDivider(
                color: AppColors.color_65AF7C,
                width: 24.w,
                thickness: 1,
              ),
              8.horizontalSpace,
              Expanded(child: child),
            ],
          ),
        )
      ],
    ).paddingOnly(left: 14.w, right: 14.w, top: 31.h);
  }
}
