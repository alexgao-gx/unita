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

class SignupFlowTallPage<T extends SignupFlowTallPageController>
    extends GetView<SignupFlowTallPageController> {
  SignupFlowTallPage({super.key});
  final List<String> height =
      List.generate(250, (index) => (index + 1).toString());
  final List<String> number =
      List.generate(10, (index) => (index + 0).toString());

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowTallPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 4),
              LargeTitle(text: 'How Tall Are \nYou?'.tr),
              const SizedBox(height: 88),
              CustomWeelPicker(
                  initialIndex1: 159,
                  initialIndex2: 0,
                  list1: height,
                  split: '.',
                  list2: number,
                  list3: controller.tallUnitEnums.map((v) => v.text).toList(),
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
                    controller.tall.value =
                        '$tallIntegerValue.$tallDecimalValue';
                    if (index3 != null) {
                      for (var v in tallUnitList) {
                        v.isSelected.value =
                            v.value == tallUnitList[index3].value;
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
          Get.toNamed(RouteNames.signupFlowWeight);
        },
      ),
    );
  }
}

class SignupFlowTallPageController extends LoadingButtonController {
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
    return false;
  }
}
