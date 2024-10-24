import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';

abstract class LoadingButtonController extends GetxController {
  /// 是否正在执行动作
  final _isLoading = false.obs;

  /// 点击事件
  Future<bool> loadingButtonPress() async {
    if (_isLoading.value || !loadingButtonEnabled()) return false;
    _isLoading.value = true;
    bool result = false;
    try {
      result = await onLoadingButtonPressed();
    } catch (e) {
      result = false;
    }
    _isLoading.value = false;
    if (result) Get.back(result: true);
    return result;
  }

  /// 点击事件
  Future<bool> onLoadingButtonPressed();

  /// 按钮是否可点击
  bool loadingButtonEnabled();

  /// 按钮是否正在loading
  bool get isLoading => _isLoading.value;
}

/// 带有加载效果的button
class LoadingButton<T extends LoadingButtonController> extends GetView<T> {
  final String? text;
  final String? controllerTag;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  const LoadingButton({super.key, this.onPressed,this.controllerTag, this.text, this.padding});

  @override
  String? get tag => controllerTag;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
        minimum: padding?? const EdgeInsets.only(bottom: 100, top: 20, left: 73, right: 73),
        child: Obx(
      () => CupertinoButton.filled(
        onPressed: controller.loadingButtonEnabled()
            ? () async {
                await controller.loadingButtonPress();
                onPressed?.call();
              }
            : null,
        padding: const EdgeInsets.all(0.0),
        disabledColor: AppColors.color_C5C5C5,
        borderRadius: BorderRadius.circular(110),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            TextWidget(
              text: text ?? '',
            ),
            if (controller.isLoading)
              const Positioned(
                  left: -25, child: ButtonProgressIndicator(size: 18)),
          ],
        ),
      ),
    ));
  }
}

class ButtonProgressIndicator extends StatelessWidget {
  final double size;
  final Brightness brightness;

  const ButtonProgressIndicator(
      {super.key, this.size = 24, this.brightness = Brightness.dark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme: CupertinoThemeData(brightness: brightness),
          ),
          child: const CupertinoActivityIndicator(),
        ));
  }
}
