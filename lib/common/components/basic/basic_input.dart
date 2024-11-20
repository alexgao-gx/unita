import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/input_suffix_clear.dart';
import 'package:unitaapp/common/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 账号、昵称、邮箱等普通文本输入框
class BasicInputWidget extends StatefulWidget {
  const BasicInputWidget(
      {super.key,
      this.hintText,
      this.controller,
      this.onTap,
      this.prefixIcon,
      this.isShowMaxCount = false,
      this.readOnly = false,
      this.errorText}); // Added errorText parameter

  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool isShowMaxCount;
  final String? errorText; // Holds the error message to display

  @override
  State<BasicInputWidget> createState() => _BasicInputWidgetState();
}

class _BasicInputWidgetState extends State<BasicInputWidget> {
  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputWidget.textBorder(
          controller: widget.controller,
          type: InputWidgetType.underlineBorder,
          contentPadding: EdgeInsets.zero,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          icon: widget.prefixIcon,
          maxLength: widget.isShowMaxCount ? 15 : null,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          hintText: widget.hintText,
          suffixIcon: Offstage(
            offstage: widget.controller?.text.isEmpty ?? true,
            child: Align(
              widthFactor: 0.5, // 宽度为自身宽度的一倍
              alignment: Alignment.centerRight, // 靠右
              child: InputSuffixClearIcon(
                onTap: widget.controller?.clear,
              ),
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }
}
