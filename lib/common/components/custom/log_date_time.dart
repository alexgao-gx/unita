import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unitaapp/common/index.dart';

import '../../style/colors.dart';
import '../../utils/widget_util.dart';
import '../../widgets/text.dart';
import 'log_date_dialog.dart';
import 'log_food_counter.dart';



class LogDateTimeWidget extends StatefulWidget {
  const LogDateTimeWidget({super.key, this.initialDateTime, this.onDateTimeChanged});
  final DateTime? initialDateTime;
  final ValueChanged<DateTime>? onDateTimeChanged;

  @override
  State<LogDateTimeWidget> createState() => _LogDateTimeWidgetState();
}

class _LogDateTimeWidgetState extends State<LogDateTimeWidget> {

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    if (widget.initialDateTime != null) {
      _dateTime = widget.initialDateTime!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            Get.dialog(
                LogDateDialog(
                    initialDate: _dateTime,
                    onDateSelected: (date) {
                      _dateTime = date;
                      widget.onDateTimeChanged?.call(_dateTime);
                      setState(() {

                      });
                    }),
                useSafeArea: false);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                  text: DateFormat.yMMMd()
                      .format(_dateTime),
                  weight: FontWeight.w700,
                  color: AppColors.color_1A342B,
                  size: 18.sp),
              7.horizontalSpace,
              Transform(
                transform: Matrix4.translationValues(0, 2, 0),
                child: IconWidget.svg(
                  'assets/svg/icon_down.svg',
                  size: 16.w,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            WidgetUtil.showTimePickerSheet(context,
                initialDate: _dateTime,
                onDateSelected: (v) {
                  _dateTime = _dateTime
                      .copyWith(hour: v.hour, minute: v.minute);
                  widget.onDateTimeChanged?.call(_dateTime);
                  setState(() {

                  });
                });
          },
          child: Row(
            children: [
              IconWidget.svg(
                size: 28.w,
                'assets/svg/ico_time.svg',
              ),
              TextWidget(
                text: DateUtil.formatDate(
                    _dateTime,
                    format: DateFormats.h_m),
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    color: AppColors.color_1A342B,
                    fontSize: 16.sp),
              ),
              5.horizontalSpace,
              Transform(
                transform: Matrix4.translationValues(0, 2, 0),
                child: IconWidget.svg(
                  'assets/svg/icon_down.svg',
                  size: 16.w,
                ),
              ),
            ],
          ),
        )
      ],
    ).padding(horizontal: 14.w, vertical: 30.h);
  }

}

