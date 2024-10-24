import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/btn_title_model.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';

import '../../common/api/user_api.dart';
import '../../common/components/basic/large_title.dart';
import '../../common/components/basic/loading_button.dart';
import '../../common/models/signup_flow_model.dart';
import '../../common/models/user_model.dart';
import '../../common/services/app_config_service.dart';

class MeAllergiesPage<T extends MeAllergiesPageController>
    extends GetView<MeAllergiesPageController> {
  MeAllergiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MeAllergiesPageController());
    final selectedAllergies = Get.find<UserService>().allergiesIds;
    for (var e in (controller.allergiesEnums)) {
      e.isSelected.value = selectedAllergies.contains(e.value);
    }
    return Scaffold(
      appBar: appBar(title: 'Allergies'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LargeTitle(text: 'Any food allergies \nor intolerances? '),
              TextWidget(
                text: 'Choose any that apply',
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
                        textWeight: FontWeight.w600,
                        textColor: AppColors.color_1A342B));
                  },
                  separatorBuilder: (_, __) => 8.verticalSpace,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Save',
        padding: EdgeInsets.symmetric(horizontal: 73, vertical: 20),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

class MeAllergiesPageController extends LoadingButtonController {
  final RxList<EnumModel> allergiesEnums =
      (Get.find<AppConfigService>().signupFlow.allergiesEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      allergiesEnums.where((v) => v.isSelected.value).isNotEmpty;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas = allergiesEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(
        UserModel(allergies: datas.map((e) => e.value).toList().join(',')));
    Get.find<UserService>().fetchUserInfo();
    return false;
  }
}
