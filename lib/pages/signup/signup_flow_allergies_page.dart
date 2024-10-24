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

class SignupFlowAllergiesPage<T extends SignupFlowAllergiesPageController>
    extends GetView<SignupFlowAllergiesPageController> {
  SignupFlowAllergiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowAllergiesPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 8),
               LargeTitle(text: 'Any food allergies \nor intolerances? '.tr),
              TextWidget(
                text: 'Choose any that apply'.tr,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: AppColors.color_456C51,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 28),
              Obx(
                () => ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.allergiesEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.allergiesEnums[index];
                    return Obx(() => ContainerText(
                        tapAction: () =>
                            item.isSelected.value = !item.isSelected.value,
                        bgColor: item.isSelected.value
                            ? AppColors.color_C1E1CE
                            : AppColors.color_FFFCF5,
                        borderRadius: 10,
                        borderWidth: item.isSelected.value ? 0 : 0.5,
                        text: item.text ?? '',
                        textSize: 16,
                        height: 43.h,
                        horPadding: 15.w,
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
        padding: const EdgeInsets.symmetric(horizontal: 73, vertical: 20),
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowGoals);
        },
      ),
    );
  }
}

class SignupFlowAllergiesPageController extends LoadingButtonController {
  final RxList<EnumModel> allergiesEnums =
      (Get.find<AppConfigService>().signupFlow.allergiesEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      allergiesEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas =
        allergiesEnums.where((v) => v.isSelected.value) ?? [];
    await UserAPI.updateUserInfo(
        UserModel(allergies: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}
