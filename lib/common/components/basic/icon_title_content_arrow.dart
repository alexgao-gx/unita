import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class IconTitleContentArrow extends StatelessWidget {
  final String imageName;
  final String title;
  final String subTitle;
  final Function goDetail;
  const IconTitleContentArrow(
      {super.key,
      required this.imageName,
      required this.title,
      required this.subTitle,
      required this.goDetail});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goDetail();
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconWidget.svg(
              imageName,
              size: 42.r,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.verticalSpace,
                  Row(
                    children: [
                      TextWidget(
                          text: title,
                          weight: FontWeight.w600,
                          color: AppColors.color_1A342B,
                          size: 22.sp),
                      IconWidget.svg(
                        'assets/svg/ico_enter.svg',
                        size: 20.r,
                      ),
                    ],
                  ),
                  Text(
                    subTitle,
                    maxLines: null,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: AppColors.color_1A342B,
                        fontSize: 12.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
