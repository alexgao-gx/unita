import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/captcha_input.dart';
import 'package:unitaapp/common/index.dart';

import '../../common/api/auth_api.dart';
import '../../common/components/basic/basic_input.dart';
import '../../common/components/basic/large_title.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/components/basic/password_input.dart';

class ForgetPwdCaptchaPage<T extends ForgetPwdCaptchaPageController>
    extends GetView<T> {
  const ForgetPwdCaptchaPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPwdCaptchaPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
             LargeTitle(text: 'Forget \nPassword'.tr),
            SizedBox(height: 115.h),
            BasicInputWidget(
                controller: controller.emailController,
                hintText: 'Enter email...'.tr),
            SizedBox(height: 40.h),
            CaptchaInputWidget<T>(),
          ],
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(text: 'Next'.tr, onPressed: () {}),
    );
  }
}

class ForgetPwdCaptchaPageController extends LoadingButtonController
    with CaptchaInputController {
  final emailController = TextEditingController();

  final emailRx = "".obs;

  @override
  void onInit() {

    emailController.addListener(() {
      emailRx.value = emailController.text;
    });

    super.onInit();
  }

  @override
  bool loadingButtonEnabled() =>
      Validators.isValidEmail(emailRx.value) && captcha.value.isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Get.toNamed(RouteNames.resetPassword,
        arguments: {'email': emailRx.value, 'captcha': captcha.value});
    return false;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  @override
  RxString get email => emailRx;
  @override
  CaptchaType get captchaType => CaptchaType.forgetPassword;

  @override
  bool sendCaptchaButtonEnabled() => emailRx.value.isNotEmpty;
}
