import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/home_log_info.dart';

class HistoryLogDays extends StatefulWidget {
  final List<HistoryInfo>? dayLogs;

  const HistoryLogDays({super.key, this.dayLogs});

  @override
  _HistoryLogDaysState createState() => _HistoryLogDaysState();
}

class _HistoryLogDaysState extends State<HistoryLogDays> {
  DateTime _selectedDate = DateTime.now();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HistoryLogDays oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDay();
    });
  }

  void _scrollToCurrentDay() {
    // 计算当前日期的位置
    int currentDayIndex = _selectedDate.day - 1;
    double itemWidth = 54.w; // 每个日期项的宽度 + margin
    double targetScrollOffset = (currentDayIndex - 1) * itemWidth;

    // 滚动到目标位置
    _scrollController.animateTo(
      targetScrollOffset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: Row(
        children: [
          10.horizontalSpace,
          TextWidget(
            text: DateFormat.MMM('zh').format(DateTime.now()),
            textAlign: TextAlign.center,
            size: 16.sp,
            weight: FontWeight.w600,
            color: AppColors.color_A7998F,
          ),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.transparent
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(left: 10.w, right: 44.w),
                scrollDirection: Axis.horizontal,
                itemCount: widget.dayLogs?.length ??
                    0, // Assuming maximum days in month is 31
                itemBuilder: (context, index) {
                  final item = widget.dayLogs?[index];
                  final progress = item?.progress ?? 0;
                  final unfinishedCurrentDay =
                      DateTime.now().day == int.tryParse(item?.day ?? '0') &&
                          progress < 100;

                  final finishedDay =
                          progress >= 100;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: 34.w,
                          alignment: Alignment.center,
                          decoration:const BoxDecoration(
                            color: AppColors.color_F8EFE9,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: finishedDay
                                ? IconWidget.svg(
                                    'assets/svg/mecoin.svg',
                                    size: 28.w,
                                  )
                                : TextWidget(
                                    text: item?.day ?? '',
                                    textAlign: TextAlign.center,
                                    size: 16.sp,
                                    weight: FontWeight.w500,
                                    color: item?.future == true
                                            ? AppColors.color_E6DCD6
                                            : AppColors.color_A7998F,
                                  ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Visibility(
                            visible: unfinishedCurrentDay || finishedDay ||
                                (progress > 0 && progress < 100),
                            child: CircularProgressIndicator(
                              strokeAlign: BorderSide.strokeAlignInside,
                              value: progress == 0
                                  ? 0.01
                                  : progress.toDouble() / 100,
                              strokeCap: StrokeCap.round,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.color_65AF7C),
                            )),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, __) => 20.horizontalSpace,
              ),
            ),
          )
        ],
      ),
    );
  }
}
