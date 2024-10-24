import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/custom_weelpicker.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../../common/api/user_api.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';

class MeHeightPage<T extends MeHeightPageController>
    extends GetView<MeHeightPageController> {
  MeHeightPage({super.key});
  final List<String> height =
  List.generate(250, (index) => (index + 1).toString());
  final List<String> number =
  List.generate(10, (index) => (index + 0).toString());

  @override
  Widget build(BuildContext context) {
    Get.put(MeHeightPageController());
    final userController = Get.find<UserService>();
    List<String> parts = userController.height.split('.');
    String integerPart = parts.length > 1 ? parts.first : userController.height;
    String decimalPart = parts.length > 1 ? parts.last : '0';

    final initialIndex1 = height.indexOf(integerPart);
    final initialIndex2 = number.indexOf(decimalPart);
    final units = (controller.tallUnitEnums).map((e) => e.value).toList();
    final initialIndex3 = units.indexOf(userController.heightUnit);
    return Scaffold(
      appBar: appBar(title: 'Height'.tr),
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(15.0),
        child: CustomWeelPicker(
            list1: height,
            split: '.',
            list2: number,
            list3: controller.tallUnitEnums.map((v) => v.text).toList(),
            initialIndex1: initialIndex1,
            initialIndex2: initialIndex2,
            initialIndex3: initialIndex3,
            onValueChanged: ({int? index1, int? index2, int? index3}) {
              final tallUnitList = controller.tallUnitEnums;
              String tallIntegerValue = '';
              String tallDecimalValue = '';
              if (index1 != null) {
                tallIntegerValue = height[index1];
              }
              if (index2 != null) {
                tallDecimalValue = number[index2];
              }
              controller.tall.value = '$tallIntegerValue.$tallDecimalValue';
              if (index3 != null) {
                for (var v in tallUnitList) {
                  v.isSelected.value = v.value == tallUnitList[index3].value;
                }
              }
            }),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Save'.tr,
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

class MeHeightPageController extends LoadingButtonController {
  final RxList<EnumModel> tallUnitEnums =
      (Get.find<AppConfigService>().signupFlow.tallUnitEnum ?? []).obs;
  final tall = ''.obs;

  @override
  bool loadingButtonEnabled() => true;

  @override
  Future<bool> onLoadingButtonPressed() async {
    EnumModel? data = tallUnitEnums.singleWhere((v) => v.isSelected.value,
        orElse: () => EnumModel());
    await UserAPI.updateUserInfo(
        UserModel(tall: tall.value, tallUnit: data.value));
    Get.find<UserService>().fetchUserInfo();
    return false;
  }
}
