import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';
import 'package:unitaapp/common/components/basic/loading_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../../common/api/user_api.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';


class SignupFlowPregnantPage<T extends SignupFlowPregnantPageController>
    extends GetView<SignupFlowPregnantPageController> {
  SignupFlowPregnantPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowPregnantPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 6),
               LargeTitle(text: 'Are You \nPregnant?'.tr),
              const SizedBox(height: 52),
              Obx(
                () => ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.pregnantEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.pregnantEnums[index];
                    return Obx(() => ContainerText(
                        tapAction: () => controller.pregnantEnums.forEach(
                            (v) => v.isSelected.value = v.value == item.value),
                        bgColor: item.isSelected.value
                            ? AppColors.color_C1E1CE
                            : AppColors.color_FFFCF5,
                        width: double.infinity,
                        height: 56,
                        borderRadius: 10,
                        borderWidth: item.isSelected.value ? 0 : 1,
                        text: item.text ?? '',
                        textSize: 16,
                        textWeight: FontWeight.w600,
                        textColor: AppColors.color_1A342B));
                  },
                  separatorBuilder: (_, __) => 8.verticalSpace,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowDiet);
        },
      ),
    );
  }
}

class SignupFlowPregnantPageController extends LoadingButtonController {
  final RxList<EnumModel> pregnantEnums =
      (Get.find<AppConfigService>().signupFlow.pregnantEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      pregnantEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    EnumModel? data = pregnantEnums.singleWhere((v) => v.isSelected.value,
        orElse: () => EnumModel());
    await UserAPI.updateUserInfo(UserModel(pregnant: data.value));
    return false;
  }
}
