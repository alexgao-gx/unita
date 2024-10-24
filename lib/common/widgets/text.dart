import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../index.dart';

/// 文字组件
class TextWidget extends StatelessWidget {
  /// 文字字符串
  final String text;

  /// 样式
  final TextStyle? style;

  /// 颜色
  final Color? color;

  /// 大小
  final double? size;

  /// 重量
  final FontWeight? weight;

  /// 行数
  final int? maxLines;

  /// 自动换行
  final bool? softWrap;

  /// 溢出
  final TextOverflow? overflow;

  /// 对齐方式
  final TextAlign? textAlign;

  final double? lineHeight;

  const TextWidget({
    Key? key,
    required this.text,
    this.style,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  }) : super(key: key);

  /// 文字 - 标题1
  TextWidget.title1(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 24, fontWeight: FontWeight.bold),
        super(key: key);

  /// 文字 - 标题2
  TextWidget.title2(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 20, fontWeight: FontWeight.w500),
        super(key: key);

  /// 文字 - 标题3
  TextWidget.title3(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 15, fontWeight: FontWeight.w500),
        super(key: key);

  /// 文字 - 正文1
  TextWidget.body1(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 15, fontWeight: FontWeight.w500),
        super(key: key);

  /// 文字 - 正文2
  TextWidget.body2(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 12, fontWeight: FontWeight.w400),
        super(key: key);

  /// 文字 - 正文3
  TextWidget.body3(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 9, fontWeight: FontWeight.w300),
        super(key: key);

  /// 文字 - 按钮
  TextWidget.button({
    Key? key,
    required this.text,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    Color? color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : color = color ?? AppColors.secondary,
        style = GoogleFonts.fahkwang(
            fontSize: 14, fontWeight: FontWeight.w500, color: color),
        super(key: key);

  /// 文字 - 导航
  TextWidget.navigation({
    Key? key,
    required this.text,
    this.maxLines = 1,
    this.softWrap = false,
    this.overflow = TextOverflow.clip,
    this.color,
    this.size,
    this.weight,
    this.textAlign,
    this.lineHeight,
  })  : style = GoogleFonts.fahkwang(fontSize: 24, fontWeight: FontWeight.w700),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == "") {
      return const SizedBox();
    }
    return Text(
      text,
      style: style ??
          GoogleFonts.fahkwang()?.copyWith(
              color: color ?? AppColors.color_FCF8F1,
              fontSize: size ?? 16,
              fontWeight: weight ?? FontWeight.w600,
              height: lineHeight),
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
