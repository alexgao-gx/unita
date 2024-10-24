import 'package:flutter/material.dart';

/// 间距
class AppSpace {
  /// 按钮
  static double get button => 5;

  /// 按钮
  static double get buttonHeight => 50;

  /// 卡片内 - 12 上下左右
  static double get card => 15;

  /// 输入框 - 10, 10 上下，左右
  static EdgeInsetsGeometry get edgeInput =>
      const EdgeInsets.symmetric(vertical: 15, horizontal: 15);

  /// 列表视图
  static double get listView => 5;

  /// 列表行 - 10 上下
  static double get listRow => 10;

  /// 列表项
  static double get listItem => 8;

  /// 页面内 - 16 左右
  static double get page => 16;

  /// 段落 - 24
  static double get paragraph => 24;

  /// 标题内容 - 10
  static double get titleContent => 10;

  /// 图标文字 - 15
  static double get iconTextSmail => 5;
  static double get iconTextMedium => 10;
  static double get iconTextLarge => 15;
}
