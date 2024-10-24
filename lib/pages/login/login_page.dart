
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/basic_input.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';
import 'package:unitaapp/common/components/basic/loading_button.dart';
import 'package:unitaapp/common/components/basic/password_input.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/auth_service.dart';
import 'package:unitaapp/pages/signup/forget_pwd_captcha_page.dart';

import '../../common/api/auth_api.dart';

class LoginPage<T extends LoginPageController> extends GetView<T> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
             LargeTitle(text: 'Welcome \nBack!'.tr),
            SizedBox(height: 115.h),
            BasicInputWidget(
                controller: controller.accountController,
                hintText: 'Enter email...'.tr),
            SizedBox(height: 40.h),
            PasswordInputWidget(
                controller: controller.pwdController,
                hintText: 'Enter password...'.tr),
            SizedBox(height: 18.h),
            UnconstrainedBox(
              alignment: Alignment.centerLeft,
              constrainedAxis: Axis.vertical,
              child: CupertinoButton(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                onPressed: () => Get.to(const ForgetPwdCaptchaPage()),
                child: TextWidget(
                  size: 14.sp,
                  weight: FontWeight.w600,
                  color: AppColors.color_456C51,
                  text: 'Forget Password?'.tr,
                  style: GoogleFonts.openSans(
                    color: AppColors.color_456C51,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.2,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: .5,
                    decorationColor: AppColors.color_456C51,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(text: 'Next'.tr),
    );
  }
}

class LoginPageController extends LoadingButtonController {
  final accountController = TextEditingController();
  final pwdController = TextEditingController();
  final accountRx = "".obs;
  final passwordRx = "".obs;


  @override
  void onInit() {
    super.onInit();
    // accountController.text = 'cavanvip@163.com';
    // pwdController.text = 'Aa@123123';

    accountController.addListener(() {
      accountRx.value = accountController.text;
    });

    pwdController.addListener(() {
      passwordRx.value = pwdController.text;
    });
  }

  @override
  bool loadingButtonEnabled() => accountRx.value.isNotEmpty && passwordRx.value.isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    final auth =
        await AuthAPI.login(accountController.text, pwdController.text);
    final authService = Get.find<AuthService>();
    authService.setAuth(auth);
    Get.offAllNamed(RouteNames.main);
    return false;
  }

  @override
  void onClose() {
    accountController.dispose();
    pwdController.dispose();
    super.onClose();
  }
}
