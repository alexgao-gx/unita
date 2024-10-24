import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

import '../../style/colors.dart';
import '../../widgets/text.dart';
import 'log_food_counter.dart';

class LogFoodItemWidget extends StatelessWidget {
  const LogFoodItemWidget(
      {super.key, required this.title, required this.numberValue, this.onRemove, this.onSaved});

  final String title;
  final String numberValue;
  final VoidCallback? onRemove;
  final ValueChanged<int>? onSaved;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.only(left: 14.w, right: 5.w),
            shape: const StadiumBorder(),
            side: const BorderSide(color: AppColors.color_1A342B, width: 0.5)),
        child: Row(
          children: [
            TextWidget(
              text: title, // 左边的文字
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  color: AppColors.color_1A342B,
                  fontSize: 14.sp),
            ),
            Expanded(
              child: TextWidget(
                text: numberValue,
                textAlign: TextAlign.right,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_1A342B,
                    fontSize: 12.sp),
              ),
            ),
            IconWidget.svg(
              size: 26.w,
              'assets/svg/ico_enter.svg',
            )
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
              context: context,
              builder: (_) =>
                  LogFoodCounterWidget(title: title, numberValue: numberValue, onSaved: onSaved,onRemove: onRemove));
        });
  }
}
