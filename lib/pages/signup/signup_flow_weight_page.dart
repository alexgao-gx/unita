import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/custom_weelpicker.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';
import 'package:unitaapp/common/components/basic/loading_button.dart';

import '../../common/api/user_api.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/routers/names.dart';
import '../../common/services/app_config_service.dart';

class SignupFlowWeightPage<T extends SignupFlowWeightPageController>
    extends GetView<SignupFlowWeightPageController> {
  SignupFlowWeightPage({super.key});
  final List<String> weight =
      List.generate(100, (index) => (index + 30).toString());
  final List<String> number =
      List.generate(10, (index) => (index + 0).toString());
  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowWeightPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 5),
               LargeTitle(text: 'What\'s Your \nCurrent Weight?'.tr),
              const SizedBox(height: 88),
              CustomWeelPicker(
                  list1: weight,
                  split: '.',
                  list2: number,
                  list3: controller.weightUnitEnums.map((v) => v.text).toList(),
                  initialIndex1: 20,
                  initialIndex2: 0,
                  initialIndex3: 0,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowPregnant);
        },
      ),
    );
  }
}

class SignupFlowWeightPageController extends LoadingButtonController {
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
    return false;
  }
}
