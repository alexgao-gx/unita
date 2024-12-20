import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';

import 'package:unitaapp/common/components/basic/loading_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/app_config_service.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../../common/api/user_api.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';

class SignupFlowGenderPage<T extends SignupFlowGenderPageController>
    extends GetView<SignupFlowGenderPageController> {
  const SignupFlowGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowGenderPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StepProgressBar(currentStep: 2),
               LargeTitle(text: 'What Is Your \nGender?'.tr),
              const SizedBox(height: 52),
              Obx(
                    () => ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.genderEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item =
                        controller.genderEnums[index] ;
                    return Obx(() => ContainerText(
                        tapAction: () => controller.genderEnums.forEach(
                                (v) => v.isSelected.value = v.value == item.value),
                        bgColor: item.isSelected.value
                            ? AppColors.color_C1E1CE
                            : AppColors.color_FFFCF5,

                        borderRadius: 10,
                        borderWidth: item.isSelected.value ? 0 : 0.5,
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
      bottomNavigationBar: LoadingButton<T>(text: 'Next'.tr, onPressed: () {
        Get.toNamed(RouteNames.signupFlowBorn);
      },),
    );
  }
}

class SignupFlowGenderPageController extends LoadingButtonController {
  final RxList<EnumModel> genderEnums =
      (Get.find<AppConfigService>().signupFlow.genderEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      genderEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    EnumModel? data = genderEnums.singleWhere((v) => v.isSelected.value,
        orElse: () => EnumModel());
    await UserAPI.updateUserInfo(UserModel(gender: data.value));
    return false;
  }
}
