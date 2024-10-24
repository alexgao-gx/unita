import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/custom_weelpicker.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../../common/api/user_api.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';
import '../../common/services/user_service.dart';

class MeWeightPage<T extends MeWeightPageController>
    extends GetView<MeWeightPageController> {
  MeWeightPage({super.key});
  final List<String> weight =
      List.generate(100, (index) => (index + 30).toString());
  final List<String> number =
      List.generate(10, (index) => (index + 0).toString());
  @override
  Widget build(BuildContext context) {
    Get.put(MeWeightPageController());
    final userController = Get.find<UserService>();
    List<String> parts = userController.weight.split('.');
    String integerPart = parts.length > 1 ? parts.first : userController.weight;
    String decimalPart = parts.length > 1 ? parts.last : '0';

    final initialIndex1 = weight.indexOf(integerPart);
    final initialIndex2 = number.indexOf(decimalPart);
    final units = controller.weightUnitEnums.map((e) => e.value).toList();
    final initialIndex3 = units.indexOf(userController.weightUnit);
    return Scaffold(
      appBar: appBar(title: 'Weight'.tr),
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(15.0),
        child: CustomWeelPicker(
            list1: weight,
            split: '.',
            list2: number,
            list3: controller.weightUnitEnums.map((v) => v.text).toList(),
            initialIndex1: initialIndex1,
            initialIndex2: initialIndex2,
            initialIndex3: initialIndex3,
            onValueChanged: ({int? index1, int? index2, int? index3}) {
              final weightUnitList = controller.weightUnitEnums;
              String weightIntegerValue = '';
              String weightDecimalValue = '';
              if (index1 != null) {
                weightIntegerValue = weight[index1];
              }
              if (index2 != null) {
                weightDecimalValue = number[index2];
              }
              controller.weight.value =
              '$weightIntegerValue.$weightDecimalValue';
              if (index3 != null) {
                for (var v in weightUnitList) {
                  v.isSelected.value =
                      v.value == weightUnitList[index3].value;
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

class MeWeightPageController extends LoadingButtonController {
  final RxList<EnumModel> weightUnitEnums =
      (Get.find<AppConfigService>().signupFlow.weightUnitEnum ?? []).obs;
  final weight = ''.obs;

  @override
  bool loadingButtonEnabled() => true;

  @override
  Future<bool> onLoadingButtonPressed() async {
    EnumModel? data = weightUnitEnums.singleWhere((v) => v.isSelected.value,
        orElse: () => EnumModel());
    await UserAPI.updateUserInfo(
        UserModel(weight: weight.value, weightUnit: data.value));
    Get.find<UserService>().fetchUserInfo();
    return false;
  }
}
