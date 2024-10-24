import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/text.dart';
import '../../common/api/user_api.dart';
import '../../common/components/basic/container_text.dart';
import '../../common/components/basic/large_title.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/components/custom/step_progress_bar.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';

class SignupFlowGoalsPage<T extends SignupFlowGoalsPageController>
    extends GetView<SignupFlowGoalsPageController> {
  SignupFlowGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowGoalsPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 9),
               LargeTitle(text: 'What are your \nmain health \ngoals?'.tr),
              TextWidget(
                text: 'Choose any that apply'.tr,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: AppColors.color_456C51,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 28),
              Obx(() {
                return GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 3.5),
                    itemCount: controller.goalEnums.length,
                    itemBuilder: (_, index) {
                      var item = controller.goalEnums[index];
                      return Obx(() => ContainerText(
                          tapAction: () =>
                              item.isSelected.value = !item.isSelected.value,
                          bgColor: item.isSelected.value
                              ? AppColors.color_C1E1CE
                              : AppColors.color_FFFCF5,
                          verPadding: 0,
                          horPadding: 12,
                          borderRadius: 10,

                          borderWidth: item.isSelected.value ? 0 : 0.5,
                          text: item.text ?? '',
                          textSize: 14,
                          textWeight: FontWeight.w500,
                          textColor: AppColors.color_1A342B));
                    });
              })
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowDisorders);
        },
      ),
    );
  }
}

class SignupFlowGoalsPageController extends LoadingButtonController {
  final RxList<EnumModel> goalEnums =
      (Get.find<AppConfigService>().signupFlow.goalsEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      goalEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas = goalEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(
        UserModel(goals: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}
