import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';

import 'package:unitaapp/common/components/basic/loading_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/app_config_service.dart';
import 'package:wheel_picker/wheel_picker.dart';

import '../../common/api/user_api.dart';
import '../../common/components/basic/custom_weelpicker.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';

class SignupFlowBornPage<T extends SignupFlowBornPageController>
    extends GetView<SignupFlowBornPageController> {
  SignupFlowBornPage({super.key});

  final secondsWheel = WheelPickerController(itemCount: 10);
  TextStyle textStyle = const TextStyle(fontSize: 32.0, height: 1.5);
  final List<String> years =
      List.generate(63, (index) => (index + 1962).toString());

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowBornPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StepProgressBar(currentStep: 3),
               LargeTitle(text: 'When Were \nYou Born?'.tr),
              const SizedBox(height: 88),
              Obx(() => CustomWeelPicker(
                  list1: years,
                  split: '｜',
                  list2: controller.bornEnums.map((v) => (v.text ?? '').capitalizeFirst ?? '').toList(),
                  list3: const [],
                  onValueChanged: ({int? index1, int? index2, int? index3}) {
                    final bornEnumList = controller.bornEnums;
                    if (index1 != null) {
                      controller.bornYear.value = years[index1];
                    }
                    if (index2 != null) {
                      for (var v in bornEnumList) {
                        v.isSelected.value =
                            v.value == bornEnumList[index2].value;
                      }
                    }
                  })),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
          text: 'Next'.tr,
          onPressed: () {
            Get.toNamed(RouteNames.signupFlowTall);
          }),
    );
  }
}

class SignupFlowBornPageController extends LoadingButtonController {
  final RxList<EnumModel> bornEnums =
      (Get.find<AppConfigService>().signupFlow.bornEnum ?? []).obs;
  final bornYear = ''.obs;

  @override
  bool loadingButtonEnabled() => true;

  @override
  Future<bool> onLoadingButtonPressed() async {
    EnumModel? data = bornEnums.singleWhere((v) => v.isSelected.value,
        orElse: () => EnumModel());
    int year = int.tryParse(bornYear.value) ?? 2000;
    int month = int.tryParse(data.value ?? '') ?? 1;
    final birth = Validators.calculateAge(DateTime(year, month));
    await UserAPI.updateUserInfo(UserModel(
        birth: DateUtil.formatDate(DateTime(year, month, 1),
            format: DateFormats.y_mo_d)));
    return false;
  }
}
