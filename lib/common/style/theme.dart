import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'index.dart';

/// 主题
class AppTheme {
  /// 亮色
  static ThemeData light = ThemeData(
      useMaterial3: false,
      primaryColor: AppColors.color_FFFCF5,
      scaffoldBackgroundColor: AppColors.color_FFFCF5,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.color_FFFCF5,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // ap
      ),
      colorScheme: lightColorScheme,
      textTheme: GoogleFonts.fahkwangTextTheme(),
      cupertinoOverrideTheme:
          const CupertinoThemeData(primaryColor: AppColors.color_65AF7C),
      inputDecorationTheme: const InputDecorationTheme(
          outlineBorder: BorderSide(color: AppColors.color_1A342B, width: 1)));

  /// 暗色
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    textTheme: GoogleFonts.fahkwangTextTheme(),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light, // appBar 亮色 , 和主题色相反
    ),
  );
}
