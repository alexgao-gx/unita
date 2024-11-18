import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../common/api/user_api.dart';
import '../../common/components/basic/large_title.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';

class SignupFlowSymptomReductionPage<T extends SignupFlowSymptomReductionPageController>
    extends GetView<SignupFlowSymptomReductionPageController> {
  SignupFlowSymptomReductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowSymptomReductionPageController());

    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 9), // Adjust step as needed
              LargeTitle(
                  text:
                      'Has your symptom(s) been reduced since you are on this/these diet(s)?'
                          .tr),
              const SizedBox(height: 20),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.symptomReductionEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.symptomReductionEnums[index];
                    return GestureDetector(
                      onTap: () => controller.symptomReductionEnums.forEach(
                          (v) => v.isSelected.value = v.value == item.value),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: item.isSelected.value
                              ? AppColors.color_C1E1CE
                              : AppColors.color_FFFCF5,
                          border: Border.all(
                              color: AppColors.color_C5C5C5, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          item.text ?? '',
                          style: TextStyle(
                            color: AppColors.color_1A342B,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowAllergies); // Navigate to the next page
        },
      ),
    );
  }
}

class SignupFlowSymptomReductionPageController extends LoadingButtonController {
  final RxList<EnumModel> symptomReductionEnums =
      (Get.find<AppConfigService>().signupFlow.symptomReductionEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      symptomReductionEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas =
        symptomReductionEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(
        UserModel(symptomReduction: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}
