import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/pages/signup/set_pwd_page.dart';
import 'package:unitaapp/common/components/basic/loading_button.dart';

import '../../common/api/auth_api.dart';
import '../../common/components/basic/basic_input.dart';
import '../../common/components/basic/captcha_input.dart';
import '../../common/components/basic/password_input.dart';
import '../../common/services/auth_service.dart';

class CreateAccountPage<T extends CreateAccountPageController>
    extends GetView<T> {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateAccountPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LargeTitle(text: 'Create You\n Account'.tr),
              SizedBox(height: 90),

              // Prefer Name Input
              BasicInputWidget(
                controller: controller.accountController,
                hintText: 'Prefer name'.tr,
                isShowMaxCount: true,
              ),
              // Email Input (Moved Below Password)
              BasicInputWidget(
                controller: controller.emailController,
                hintText: 'Enter your email...'.tr,
              ),
              SizedBox(height: 20.h),

              // Password Inputs
              PasswordInputWidget(
                controller: controller.pwdController,
                hintText: 'Enter password...'.tr,
                isShowMaxCount: true,
              ),
              PasswordInputWidget(
                controller: controller.confirmPwdController,
                hintText: 'Enter password again...'.tr,
                isShowValidateText: true,
              ),

              // Add spacing




              // Captcha Input (Moved Below Password)
              SizedBox(height: 20.h),
              CaptchaInputWidget<T>(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {},
      ),
    );
  }
}

class CreateAccountPageController extends LoadingButtonController
    with CaptchaInputController {
  final accountController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final accountRx = "".obs;
  final emailRx = "".obs;
  final passwordRx = "".obs;
  final confirmPasswordRx = "".obs;

  @override
  void onInit() {
    super.onInit();
    // accountController.text = 'Cavan';
    // emailController.text = 'cavanvip@163.com';
    // pwdController.text = 'Aa@123123';
    // confirmPwdController.text = 'Aa@123123';

    accountController.addListener(() {
      accountRx.value = accountController.text;
    });

    emailController.addListener(() {
      emailRx.value = emailController.text;
    });

    pwdController.addListener(() {
      passwordRx.value = pwdController.text;
    });

    confirmPwdController.addListener(() {
      confirmPasswordRx.value = confirmPwdController.text;
    });
  }

  @override
  bool loadingButtonEnabled() =>
      accountRx.value.isNotEmpty &&
      Validators.isValidEmail(emailRx.value) &&
      passwordRx.value.isNotEmpty &&
      confirmPasswordRx.value.isNotEmpty &&
      passwordRx.value == confirmPasswordRx.value &&
      captcha.value.isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    final auth = await AuthAPI.register(email.value,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        captcha: captcha.value);
    final authService = Get.find<AuthService>();
    authService.setAuth(auth);
    Get.offAllNamed(RouteNames.main);
    Get.toNamed(RouteNames.signupFlowStart);
    return false;
  }

  @override
  void onClose() {
    accountController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    super.onClose();
  }

  @override
  RxString get email => emailRx;
  @override
  String get username => accountController.text;
  @override
  String get password => pwdController.text;
  @override
  String get confirmPassword => confirmPwdController.text;
  @override
  CaptchaType get captchaType => CaptchaType.createAccount;

  // @override
  // bool sendCaptchaButtonEnabled() =>
  //     emailRx.isNotEmpty &&
  //     accountRx.isNotEmpty &&
  //     passwordRx.isNotEmpty &&
  //     confirmPasswordRx.isNotEmpty;
  @override
  bool sendCaptchaButtonEnabled() => true;

  @override
  performClickSendSmsCodeButton() {
    if (username.isEmpty) {
      Loading.toast('please enter prefer name'.tr);
      return;
    }
    if (email.isEmpty) {
      Loading.toast('please enter email'.tr);
      return;
    }
    if (password.isEmpty) {
      Loading.toast('please enter password'.tr);
      return;
    }
    if (confirmPassword.isEmpty) {
      Loading.toast('please enter password again'.tr);
      return;
    }
    return super.performClickSendSmsCodeButton();
  }
}
