
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class ChatBottomBar extends StatelessWidget {
  ChatBottomBar({super.key, required this.callBack});
  final Function(String value) callBack;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // 添加焦点监听器
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // 当TextField获取焦点时执行的操作
        print('TextField gained focus');
        callBack('gained focus');
      } else {
        // 当TextField失去焦点时执行的操作
        print('TextField lost focus');
      }
    });
    return Container(
      // height: 34,
      margin: EdgeInsets.only(left: 11.w, right: 13.w, bottom: 30.h),
      // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        children: [
          // IconWidget.svg(
          //   'assets/svg/ico_take photo.svg',
          //   size: 30,
          // ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0), // 调整容器内边距
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.color_456C51, // 边框颜色为红色
                  width: 1.0, // 边框宽度为1像素
                ),
                borderRadius: BorderRadius.circular(21.0), // 圆角半径为16像素
              ),
              child: TextField(
                focusNode: _focusNode,
                maxLines: null,
                controller: _controller,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 6.h,
                    ),
                    border: InputBorder.none, // 移除输入框的默认边框
                    hintText: 'Message...'.tr,
                    hintStyle: const TextStyle(
                        fontSize: 16, color: AppColors.color_C5C5C5) // 输入框的提示文本
                    ),
                onSubmitted: (String value) {
                  callBack(value);
                  _controller.clear();
                },
                onEditingComplete: () {
                  print('objectobjectobject');
                },
                onChanged: (String value) {
                  // 检查文本中是否包含换行符
                  if (value.contains('\n')) {
                    // // 如果包含换行符，移除换行符并将文本设置回去
                    // _controller.text = value.replaceAll('\n', '');
                    // // 执行你的操作
                    // callBack(_controller.text);
                    // // 将光标移动到文本末尾
                    // _controller.selection = TextSelection.collapsed(
                    //     offset: _controller.text.length);
                    callBack(value.replaceAll('\n', ''));
                    _controller.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 9),
          // IconWidget.svg(
          //   'assets/svg/ico_voice.svg',
          //   size: 30,
          // ),
          // const SizedBox(width: 9),
          // IconWidget.svg(
          //   'assets/svg/ico_add.svg',
          //   size: 30,
          // ),
        ],
      ),
    );
  }
}
