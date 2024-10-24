import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';

import '../../common/api/auth_api.dart';
import '../../common/components/basic/basic_input.dart';
import '../../common/components/basic/large_title.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/components/basic/password_input.dart';

class ForgetPwdPage<T extends ForgetPwdPageController> extends GetView<T> {
  const ForgetPwdPage({super.key, this.email, this.captcha});
  final String? email;
  final String? captcha;

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPwdPageController(email: email, captcha: captcha));
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
            PasswordInputWidget(
              controller: controller.newPwdController,
              hintText: 'Enter new password'.tr,
              isShowMaxCount: true,
            ),
            SizedBox(height: 40.h),
            PasswordInputWidget(
              controller: controller.confirmPwdController,
              hintText: 'Enter new password again'.tr,
              isShowValidateText: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(text: 'Next'.tr, onPressed: () {}),
    );
  }
}

class ForgetPwdPageController extends LoadingButtonController {
  ForgetPwdPageController({this.email, this.captcha});

  final newPwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final newPasswordRx = "".obs;
  final confirmPasswordRx = "".obs;
  final String? email;
  final String? captcha;

  @override
  void onInit() {

    newPwdController.addListener(() {
      newPasswordRx.value = newPwdController.text;
    });

    confirmPwdController.addListener(() {
      confirmPasswordRx.value = confirmPwdController.text;
    });
    super.onInit();
  }

  @override
  bool loadingButtonEnabled() =>
      newPasswordRx.value.isNotEmpty &&
      confirmPasswordRx.value.isNotEmpty &&
      newPasswordRx.value == confirmPasswordRx.value;

  @override
  Future<bool> onLoadingButtonPressed() async {
   final result = await AuthAPI.resetPassword(email ?? '',
        username: email,
        password: newPasswordRx.value,
        confirmPassword: confirmPasswordRx.value,
        captcha: captcha);
   if (result is String) {
     Loading.toast(result);
   }
    Get.back();
    return true;
  }

  @override
  void onClose() {
    newPwdController.dispose();
    confirmPwdController.dispose();
    super.onClose();
  }
}
