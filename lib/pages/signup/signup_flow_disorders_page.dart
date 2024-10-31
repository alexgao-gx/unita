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

class SignupFlowDisordersPage<T extends SignupFlowDisordersPageController>
    extends GetView<SignupFlowDisordersPageController> {
  SignupFlowDisordersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowDisordersPageController());

    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 10),
               LargeTitle(
                  text: 'Got any \ndiagnosed \ngastrointestinal \ndisorders?'.tr),
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.disordersEnums.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = controller.disordersEnums[index];
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
                        textWeight: FontWeight.w500,
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
        padding: EdgeInsets.symmetric(horizontal: 73, vertical: 20),
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowConditions);
        },
      ),
    );
  }
}

class SignupFlowDisordersPageController extends LoadingButtonController {
  final RxList<EnumModel> disordersEnums =
      (Get.find<AppConfigService>().signupFlow.gastroEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      disordersEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas = disordersEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(UserModel(
        gastrointestinal: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}