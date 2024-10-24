import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/user_model.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/components/basic/loading_button.dart';
import '../../common/components/basic/basic_input.dart';
import '../../common/services/user_service.dart';

class MeUserNamePage<T extends MeUsernamePageController> extends GetView<T> {
  const MeUserNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MeUsernamePageController());
    return Scaffold(
      appBar: appBar(title: 'UserName'.tr),
      body: Container(
        margin: const EdgeInsets.only(top: 180),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BasicInputWidget(
                controller: controller.accountController,
                hintText: 'Enter nickname...'.tr,
                isShowMaxCount: true),
            const SizedBox(
              height: 144,
            ),
            LoadingButton<T>(text: 'Next'.tr, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class MeUsernamePageController extends LoadingButtonController {
  final accountController = TextEditingController();
  final accountRx = "".obs;

  final userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    accountController.addListener(() {
      accountRx.value = accountController.text;
    });
    accountController.text = userService.username;
  }

  @override
  bool loadingButtonEnabled() =>
      accountRx.value.isNotEmpty && accountRx.value != userService.username;

  @override
  Future<bool> onLoadingButtonPressed() async {
   await userService.updateUserInfo(UserModel(username: accountController.text));
    return true;
  }

  @override
  void onClose() {
    accountController.dispose();
    super.onClose();
  }
}
