import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unitaapp/common/index.dart';

class LogDateDialog extends StatefulWidget {

final ValueChanged<DateTime>? onDateSelected;
final DateTime? initialDate;

  const LogDateDialog({super.key, this.onDateSelected, this.initialDate});
  @override
  _LogDateDialogState createState() => _LogDateDialogState();
}

class _LogDateDialogState extends State<LogDateDialog> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  void initState() {
    _selectedDay = widget.initialDate ?? DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r))),
        child: SafeArea(
            child: TableCalendar(
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronMargin: EdgeInsets.only(left: 80.w),
            rightChevronMargin: EdgeInsets.only(right: 80.w),
            titleTextFormatter: (date,_) => DateFormat.MMMM().format(date)
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration:const BoxDecoration(
              color: AppColors.color_65AF7C,
              shape: BoxShape.circle
            ),
            selectedTextStyle: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            defaultTextStyle: GoogleFonts.openSans(
              color: AppColors.color_456C51,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            disabledTextStyle: GoogleFonts.openSans(
              color: AppColors.color_C1E1CE,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            outsideTextStyle: GoogleFonts.openSans(
              color: AppColors.color_C1E1CE,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            todayDecoration: BoxDecoration(
                color: AppColors.color_C1E1CE,
                shape: BoxShape.circle
            ),

          ),
          firstDay: DateTime(2020),
          lastDay: DateTime.now(),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              widget.onDateSelected?.call(_selectedDay!);
              Get.back();
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        )),
      ),
    );
  }
}
