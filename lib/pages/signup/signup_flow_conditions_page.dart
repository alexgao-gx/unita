import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text.dart';
import 'package:unitaapp/common/components/basic/large_title.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';

import '../../common/api/user_api.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';

class SignupFlowConditionsPage<T extends SignupFlowConditionsPageController>
    extends GetView<SignupFlowConditionsPageController> {
  SignupFlowConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowConditionsPageController());

    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 11),
               LargeTitle(text: 'Do you have \nmedical \nconditions?'.tr),
              const SizedBox(height: 28),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.conditionEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.conditionEnums[index];
                    return Obx(() => ContainerText(
                        tapAction: () => controller.conditionEnums.forEach(
                            (v) => v.isSelected.value = v.value == item.value),
                        bgColor: item.isSelected.value
                            ? AppColors.color_C1E1CE
                            : AppColors.color_FFFCF5,

                        borderRadius: 10,
                        borderWidth: item.isSelected.value ? 0 : 0.5,
                        text: item.text ?? '',
                        textSize: 16,
                        textWeight: FontWeight.w500,
                        textColor: AppColors.color_1A342B));
                  },
                  separatorBuilder: (_, __) => 8.verticalSpace,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    color: AppColors.color_F3F7ED,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWidget.svg('assets/svg/ico_warning.svg', size: 30),
                    SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 5),
                        TextWidget(
                          text: 'Medical warning'.tr,
                          size: 16,
                          weight: FontWeight.w500,
                          color: AppColors.color_1A342B,
                        ),
                        SizedBox(height: 10),
                        TextWidget(
                            text:
                                'Unita\'s recommendations are for information only, consult medical professionals who are specialized on eating disorders before implement any recommendations.'.tr,
                            softWrap: true,
                            maxLines: null,
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.color_1A342B)),
                      ],
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowMedicals);
        },
      ),
    );
  }
}

class SignupFlowConditionsPageController extends LoadingButtonController {
  final RxList<EnumModel> conditionEnums =
      (Get.find<AppConfigService>().signupFlow.yesNoEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      conditionEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas = conditionEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(
        UserModel(medical: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}
