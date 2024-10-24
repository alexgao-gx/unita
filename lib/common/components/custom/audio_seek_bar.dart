import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';

class AudioSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const AudioSeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  _AudioSeekBarState createState() => _AudioSeekBarState();
}

class _AudioSeekBarState extends State<AudioSeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 70.h,child: Stack(
      children: [
        // SliderTheme(
        //   data: _sliderThemeData.copyWith(
        //     // thumbShape: HiddenThumbComponentShape(),
        //     activeTrackColor: Colors.blue.shade100,
        //     inactiveTrackColor: Colors.grey.shade300,
        //   ),
        //   child: ExcludeSemantics(
        //     child: Slider(
        //       min: 0.0,
        //       max: widget.duration.inMilliseconds.toDouble(),
        //       value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
        //           widget.duration.inMilliseconds.toDouble()),
        //       onChanged: (value) {
        //         setState(() {
        //           _dragValue = value;
        //         });
        //         if (widget.onChanged != null) {
        //           widget.onChanged!(Duration(milliseconds: value.round()));
        //         }
        //       },
        //       onChangeEnd: (value) {
        //         if (widget.onChangeEnd != null) {
        //           widget.onChangeEnd!(Duration(milliseconds: value.round()));
        //         }
        //         _dragValue = null;
        //       },
        //     ),
        //   ),
        // ),
        Positioned(
          left: 20.w,
          bottom: 0,
          child: TextWidget(
              text:  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("${widget.position}")
                  ?.group(1) ??
                  '${widget.position}',
              style: GoogleFonts.openSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.color_A7998F)),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: AppColors.color_E6DCD6,
            thumbColor: Colors.white,
            activeTrackColor: AppColors.color_65AF7C,
            trackHeight: 2.r,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 20.w,
          bottom: 0,
          child: TextWidget(
              text:  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("${widget.duration}")
                  ?.group(1) ??
                  '${widget.duration}',
              style: GoogleFonts.openSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.color_A7998F)),
        ),
      ],
    ),);
  }

  Duration get _remaining => widget.duration - widget.position;
}