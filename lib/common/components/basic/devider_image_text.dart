import 'package:flutter/material.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';

class DividerImageText extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function() goDetail;

  const DividerImageText({
    super.key,
    required this.text,
    required this.icon,
    required this.goDetail,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // goDetail();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        // decoration: const BoxDecoration(
        //   border: Border(
        //     top: BorderSide(color: Colors.red, width: 1.0),
        //     bottom: BorderSide(color: Colors.red, width: 1.0),
        //   ),
        // ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              child: Divider(
                height: 1,
                color: AppColors.color_E6DCD6,
              ),
            ),
            const SizedBox(width: 10.0),
            icon,
            const SizedBox(width: 10.0),
            TextWidget(
                text: text,
                weight: FontWeight.w400,
                color: AppColors.color_1A342B,
                size: 12),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Divider(
                height: 1,
                color: AppColors.color_E6DCD6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
