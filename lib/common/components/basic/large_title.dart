import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unitaapp/common/index.dart';

class LargeTitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const LargeTitle({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.sp),
      child: TextWidget(
        text: text,
        maxLines: null,
        softWrap: true,
        size: fontSize ?? 36.sp,
        weight: fontWeight ?? FontWeight.w600,
        color: AppColors.color_1A342B,
      ),
    );
  }
}
