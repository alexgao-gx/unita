import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/signup_flow_model.dart';
import '../../style/colors.dart';
import '../../widgets/icon.dart';
import '../../widgets/text.dart';
import '../basic/container_text.dart';
import 'log_add_input_dialog.dart';

class LogBmAppearancesWidget extends StatefulWidget {
  LogBmAppearancesWidget({
    super.key,
    this.onBmAppearanceChanged,
    this.datas,
    this.showAdd = true,
    this.crossAxisCount,
    this.childAspectRatio,
  });

  final bool? showAdd;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final List<EnumModel>? datas;
  final ValueChanged<EnumModel>? onBmAppearanceChanged;

  @override
  State<LogBmAppearancesWidget> createState() => _LogBmAppearancesWidgetState();
}

class _LogBmAppearancesWidgetState extends State<LogBmAppearancesWidget> {
  List<EnumModel> get bmAppearances => widget.datas ?? <EnumModel>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.showAdd == true
          ? bmAppearances.length + 1
          : bmAppearances.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount ?? 2,
        childAspectRatio: widget.childAspectRatio ?? 3, // Adjust for more width
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemBuilder: (context, index) {
        if (index == bmAppearances.length) {
          // Add Button
          return _buildAddButton();
        } else {
          // Appearance Items
          final item = bmAppearances[index];
          return _buildAppearanceItem(item);
        }
      },
    );
  }

  /// Build Add Button
  Widget _buildAddButton() {
    return OutlinedButton(
      onPressed: () {
        Get.dialog(
          LogAddInputDialog(onValueUpdated: (v) {
            _handleAddInput(v);
          }),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const StadiumBorder(),
        side: const BorderSide(color: AppColors.color_456C51, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconWidget.svg(
            size: 16.w,
            'assets/svg/ico_plus.svg',
          ),
          5.horizontalSpace,
          TextWidget(
            text: 'Add'.tr,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.color_456C51,
            ),
          ),
        ],
      ),
    );
  }

  /// Build Appearance Item
  Widget _buildAppearanceItem(EnumModel item) {
    return ContainerText(
      tapAction: () => _handleTap(item),
      bgColor: item.isSelected.value
          ? AppColors.color_C1E1CE
          : AppColors.color_FFFCF5,
      verPadding: 0,
      horPadding: 0,
      borderRadius: 50,
      borderWidth: item.isSelected.value ? 0 : 0.5,
      text: item.text ?? '',
      textSize: 14.sp,
      textAlign: TextAlign.center,
      textWeight: FontWeight.w500,
      textColor: item.isSelected.value
          ? AppColors.color_1A342B
          : AppColors.color_A7998F,
      borderColor: item.isSelected.value
          ? AppColors.color_C1E1CE
          : AppColors.color_A7998F,
      // Handle long text overflow
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Handle Add Input Logic
  void _handleAddInput(String v) {
    final duplicates = bmAppearances.where((e) => e.text == v);
    if (duplicates.isEmpty) {
      final appearance = EnumModel(text: v);
      bmAppearances.add(appearance);
      widget.onBmAppearanceChanged?.call(appearance);
    } else {
      widget.onBmAppearanceChanged?.call(duplicates.first);
    }
    _updateSelection(v);
  }

  /// Handle Tap on Appearance
  void _handleTap(EnumModel item) {
    bmAppearances.forEach((v) {
      v.isSelected.value = v.text == item.text ? !v.isSelected.value : false;
    });
    widget.onBmAppearanceChanged?.call(item);
    setState(() {});
  }

  /// Update Selection
  void _updateSelection(String value) {
    bmAppearances.forEach((e) => e.isSelected.value = e.text == value);
    setState(() {});
  }
}
