import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/style/colors.dart';

class InputMinPlusNumber1 extends StatelessWidget {
  InputMinPlusNumber1({super.key, required this.title});
  final String title;
  var number = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0), // 设置边框宽度为2px
        borderRadius: BorderRadius.circular(8.0), // 设置边框圆角
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // 水平居中对齐
        // textBaseline: TextBaseline.ideographic, // 或者 TextBaseline.ideographic
        children: [
          Text(
            title, // 左边的文字
            style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: AppColors.color_456C51,
                fontSize: 12), // 设置文字大小
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // 水平居中对齐
            children: [
              InkWell(
                onTap: () {
                  number.value--;
                },
                child: SizedBox(
                    width: 10,
                    height: 10,
                    child: Image.asset('assets/images/jianhao.png')),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(() {
                return Text(
                  '${number.value}', // 数字
                  style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      color: AppColors.color_1A342B,
                      fontSize: 12), // 设置文字大小
                );
              }),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  number.value++;
                },
                child: SizedBox(
                    width: 10,
                    height: 10,
                    child: Image.asset('assets/images/jiahao.png')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
