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


class SignupFlowDietPage<T extends SignupFlowDietPageController>
    extends GetView<SignupFlowDietPageController> {
  SignupFlowDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowDietPageController());
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StepProgressBar(currentStep: 7),
               LargeTitle(text: 'What\'s your diet \nlike right now? '.tr),
              TextWidget(
                text: 'Choose any that apply'.tr,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: AppColors.color_456C51,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 28),
              Obx(() {

                final dietEnums = controller.dietEnums.sublist(0, min(controller.dietEnums.length, 9));

                return StaggeredGrid.count(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: dietEnums
                      .map((e) => StaggeredGridTile.count(
                            crossAxisCellCount: e == dietEnums.last ? 6 : 3,
                            mainAxisCellCount: 1,
                            child: _buildGridViewItem(e, dietEnums.indexOf(e)),
                          ))
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LoadingButton<T>(
        text: 'Next'.tr,
        onPressed: () {
          Get.toNamed(RouteNames.signupFlowAllergies);
        },
      ),
    );
  }

  Widget _buildGridViewItem(EnumModel item, int index) =>
      Obx(() => GestureDetector(
          onTap: () => item.isSelected.value = !item.isSelected.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13), // 设置容器的内边距
            decoration: BoxDecoration(
              color: item.isSelected.value
                  ? AppColors.color_C1E1CE
                  : AppColors.color_FFFCF5,
              border: Border.all(
                  color: AppColors.color_C5C5C5,
                  width: item.isSelected.value ? 0 : 1), // 设置容器的边框
              borderRadius: BorderRadius.circular(10.0),
              // color: backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // 左边的图标
                if (index < 8)
                  IconWidget.svg('assets/svg/diet${index + 1}.svg', size: 40),
                const SizedBox(width: 9.0), // 添加一些水平间距
                // 要加Expanded，否则文字会溢出，不会换行
                Expanded(
                  child: TextWidget(
                    text: item.text ?? '',
                    color: AppColors.color_1A342B,
                    size: 16,
                    weight: FontWeight.w600,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )));
}


class SignupFlowDietPageController extends LoadingButtonController {
  final RxList<EnumModel> dietEnums =
      (Get.find<AppConfigService>().signupFlow.dietEnum ?? []).obs;

  @override
  bool loadingButtonEnabled() =>
      dietEnums.where((v) => v.isSelected.value).isNotEmpty ;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Iterable<EnumModel> datas =
        dietEnums.where((v) => v.isSelected.value);
    await UserAPI.updateUserInfo(UserModel(diet: datas.map((e) => e.value).toList().join(',')));
    return false;
  }
}