import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

class SliderTextWidget extends StatefulWidget {
  const SliderTextWidget({
    super.key,
    this.datas,
    this.initial,
    this.onValueChanged,
    this.showSliderText = true,
  });
  final List<EnumModel>? datas;
  final ValueChanged<EnumModel>? onValueChanged;
  final EnumModel? initial;
  final bool? showSliderText;
  @override
  State<SliderTextWidget> createState() => _SliderTextWidgetState();
}

class _SliderTextWidgetState extends State<SliderTextWidget> {
  List<EnumModel> get _sliderModels => widget.datas ?? <EnumModel>[];
  late double _sliderValue = 0;
  @override
  void initState() {
    int index = 0;
    if (widget.initial != null) {
      index = _sliderModels.indexWhere((e) => e.value == widget.initial!.value);
    } else {
      index = _sliderModels.indexWhere((e) => e.isSelected.value == true);
    }
    index = max(0, index);
    if (_sliderModels.isNotEmpty) {
      _sliderValue = index / _sliderModels.length;
    } else {
      _sliderValue = 0;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SliderTheme(
          data: const SliderThemeData(
              tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 4.0),
              trackShape: RectangularSliderTrackShape(),
              trackHeight: 1.0),
          child: Slider(
              inactiveColor: AppColors.color_C5C5C5,
              activeColor: AppColors.color_C5C5C5,
              thumbColor: Colors.white,
              value: _sliderModels.isNotEmpty
                  ? min(
                      1,
                      max(
                          0,
                          _sliderModels.indexWhere(
                                  (e) => e.isSelected.value == true) /
                              (_sliderModels.length - 1)))
                  : 0,
              divisions: max(1, _sliderModels.length - 1),
              onChanged: (value) {
                final divisionCount = max(1, _sliderModels.length - 1);
                int result = value ~/ (1.0 / divisionCount);
                for (int i = 0; i < _sliderModels.length; i++) {
                  _sliderModels[i].isSelected.value = result == i;
                }
                _sliderValue = value;
                widget.onValueChanged?.call(_sliderModels[result]);
                setState(() {});
              }).padding(horizontal: 20.w),
        ),
        _sliderModels.isNotEmpty && widget.showSliderText == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _sliderModels.map((model) {
                  return Expanded(
                    child: TextWidget(
                      maxLines: null,
                      softWrap: true,
                      text: model.text ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                        color: model.isSelected.value
                            ? AppColors.color_65AF7C
                            : AppColors.color_456C51,
                        fontWeight: model.isSelected.value
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ).paddingHorizontal(14.w)
            : const SizedBox.shrink(),
      ],
    );
  }
}
