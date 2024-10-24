import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import '../../api/auth_api.dart';

enum CaptchaType { createAccount, forgetPassword }

mixin CaptchaInputController on GetLifeCycle {

  /// 短信验证码
  late TextEditingController captchaController;
  final captcha = "".obs;

  // 倒计时
  final captchaCounter = 0.obs;
  Timer? _timer;

  RxString get email;
  String get username => email.value;
  String get password => '';
  String get confirmPassword => '';

  CaptchaType get captchaType;

  bool get isShowSmsCodeButton => email.value.length == 11;

  String get smsCodeButtonText => captchaCounter.value == 0
      ? 'Send'.tr
      : 'Send Again'.trArgs([captchaCounter.value.toString()]);

  /// 是否发送验证码
  final isSendingCode = false.obs;

  /// 按钮是否可点击
  bool sendCaptchaButtonEnabled();

  @override
  void onInit() {
    captchaController = TextEditingController();
    captchaController.addListener(() {
      captcha.value = captchaController.text;
    });
    super.onInit();
  }

  @override
  void onClose() {
    captchaController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  /// 发送短信验证码
  performClickSendSmsCodeButton() async {
    if (!Validators.isValidEmail(email.value)) {
      Loading.toast('Please input a valid email'.tr);
      return;
    }

    _timer?.cancel();
    captchaController.text = '';
    captchaCounter.value = 60;

    Loading.show();
    try {
      if (captchaType == CaptchaType.createAccount) {
        await AuthAPI.sendCaptchaWhenCreateAccount(email.value,
            username: username,
            password: password,
            confirmPassword: confirmPassword);
      } else {
        await AuthAPI.sendCaptchaWhenForgetPassword(email.value);
      }
      Loading.toast('Send Success'.tr);
      // 倒计时
      startCountdown();
    } catch (e) {
      /// 重置验证码倒计时
      captchaCounter.value = 0;
    }
    Loading.dismiss();
  }

  /// 倒计时
  void startCountdown() {
    _timer = Timer.periodic(1.seconds, (timer) {
      captchaCounter.value--;
      if (captchaCounter.value == 0) {
        _timer?.cancel();
      }
    });
  }
}

class CaptchaInputWidget<T extends CaptchaInputController> extends GetView<T> {
  const CaptchaInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InputWidget.textBorder(
      controller: controller.captchaController,
      type: InputWidgetType.underlineBorder,
      contentPadding: EdgeInsets.zero,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      keyboardType: TextInputType.number,
      hintText: 'Verify code'.tr,
      suffixIcon: SmsCodeSendButton<T>(),
    );
  }
}

/// 短信验证码
class SmsCodeSendButton<T extends CaptchaInputController> extends GetView<T> {
  const SmsCodeSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const SizedBox(
          height: 30,
          child: IntrinsicHeight(
            child: VerticalDivider(
              color: AppColors.color_1A342B,
              thickness: 1,
              width: 25,
              endIndent: 5,
              indent: 5,
            ),
          ),
        ),
        Obx(
          () => InkWell(
            onTap: controller.captchaCounter.value == 0 && controller.sendCaptchaButtonEnabled()
                ? controller.performClickSendSmsCodeButton
                : null,
            child: Center(
                widthFactor: 1.1,
                child: TextWidget(
                  text: controller.smsCodeButtonText,
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: controller.captchaCounter.value == 0
                          ? AppColors.color_1A342B
                          : AppColors.color_C5C5C5),
                )),
          ),
        )
      ],
    );
  }
}
