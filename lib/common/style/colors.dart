import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color color_C1E1CE = Color(0xffC1E1CE);
  static const Color color_65AF7C = Color(0xff65AF7C);
  static const Color color_1A342B = Color(0xff1A342B);
  static const Color color_F3F7ED = Color(0xffF3F7ED);
  static const Color color_204740 = Color(0xff204740);
  static const Color color_FFFCF5 = Color(0xffFFFCF5);
  static const Color color_D9D9D9 = Color(0xffD9D9D9);
  static const Color color_456C51 = Color(0xff456C51);
  static const Color color_B5C2B3 = Color(0xffB5C2B3);
  static const Color color_C5C5C5 = Color(0xffC5C5C5);
  static const Color bgColor = Color.fromRGBO(255, 251, 243, 1);
  static const Color color_E0EFE1 = Color(0xffE0EFE1);
  static const Color color_FCF8F1 = Color(0xffFCF8F1);
  static const Color color_D7D4D0 = Color(0xffD7D4D0);

  static const Color color_683610 = Color(0xff683610);
  static const Color color_E7C65B = Color(0xffE7C65B);
  static const Color color_BFA071 = Color(0xffBFA071);
  static const Color color_4D392E = Color(0xff4D392E);
  static const Color color_3D6543 = Color(0xff3D6543);
  static const Color color_222222 = Color(0xff222222);
  static const Color color_BF5B59 = Color(0xffBF5B59);
  static const Color color_2F5448 = Color(0xff2F5448);
  static const Color color_E6DCD6 = Color(0xffE6DCD6);
  static const Color color_D9F0F8 = Color(0xffD9F0F8);
  static const Color color_A7998F = Color(0xffA7998F);
  static const Color color_FD8A5E = Color(0xffFD8A5E);
  static const Color color_F8EFE9 = Color(0xffF8EFE9);
  /// *******************************************
  /// 自定义 颜色
  /// *******************************************

  /// 强调
  static Color get highlight =>
      Get.isDarkMode ? const Color(0xFFFFB4A9) : const Color(0xFFF77866);

  /// Success
  /// Warning
  /// Danger
  /// Info

  /// *******************************************
  /// Material System
  /// *******************************************

  static Color get background => Get.theme.colorScheme.background;

  static Brightness get brightness => Get.theme.colorScheme.brightness;

  static Color get error => Get.theme.colorScheme.error;

  static Color get errorContainer => Get.theme.colorScheme.errorContainer;

  static Color get inversePrimary => Get.theme.colorScheme.inversePrimary;

  static Color get inverseSurface => Get.theme.colorScheme.inverseSurface;

  static Color get onBackground => Get.theme.colorScheme.onBackground;

  static Color get onError => Get.theme.colorScheme.onError;

  static Color get onErrorContainer => Get.theme.colorScheme.onErrorContainer;

  static Color get onInverseSurface => Get.theme.colorScheme.onInverseSurface;

  static Color get onPrimary => Get.theme.colorScheme.onPrimary;

  static Color get onPrimaryContainer =>
      Get.theme.colorScheme.onPrimaryContainer;

  static Color get onSecondary => Get.theme.colorScheme.onSecondary;

  static Color get onSecondaryContainer =>
      Get.theme.colorScheme.onSecondaryContainer;

  static Color get onSurface => Get.theme.colorScheme.onSurface;

  static Color get onSurfaceVariant => Get.theme.colorScheme.onSurfaceVariant;

  static Color get onTertiary => Get.theme.colorScheme.onTertiary;

  static Color get onTertiaryContainer =>
      Get.theme.colorScheme.onTertiaryContainer;

  static Color get outline => Get.theme.colorScheme.outline;

  static Color get primary => Get.theme.colorScheme.primary;

  static Color get primaryContainer => Get.theme.colorScheme.primaryContainer;

  static Color get secondary => Get.theme.colorScheme.secondary;

  static Color get secondaryContainer =>
      Get.theme.colorScheme.secondaryContainer;

  static Color get shadow => Get.theme.colorScheme.shadow;

  static Color get surface => Get.theme.colorScheme.surface;

  static Color get surfaceVariant => Get.theme.colorScheme.surfaceVariant;

  static Color get tertiary => Get.theme.colorScheme.tertiary;

  static Color get tertiaryContainer => Get.theme.colorScheme.tertiaryContainer;
}
