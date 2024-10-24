import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_icon.dart';
import 'package:unitaapp/common/components/custom/profile_item.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/app_config_service.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/pages/me/me_allergies_page.dart';
import 'package:unitaapp/pages/me/me_assessment_page.dart';
import 'package:unitaapp/pages/me/me_height_page.dart';
import 'package:unitaapp/pages/me/me_username_page.dart';
import 'package:unitaapp/pages/me/me_weight_page.dart';

import '../../common/models/signup_flow_model.dart';
import '../../common/utils/permissions_util.dart';
import '../../common/utils/widget_util.dart';

class MeProfilePage<T extends AppConfigService>
    extends GetView<AppConfigService> {
  @override
  Widget build(BuildContext context) {
    final userConroller = Get.find<UserService>();
    return Scaffold(
      appBar: appBar(title: 'Profile'.tr),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Obx(
                  () => userConroller.headImageUrl.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            WidgetUtil.showUploadImageOperations(context,
                                () async {
                              if (await PermissionsUtil
                                  .requestCameraPermission()) {
                                userConroller.updateAvatar(false);
                              }
                            }, () async {
                              if (await PermissionsUtil
                                  .requestStoragePermission()) {
                                userConroller.updateAvatar(true);
                              }
                            });
                          },
                          child: ImageWidget(
                            type: ImageWidgetType.network,
                            url: userConroller.headImageUrl,
                            fit: BoxFit.fill,
                            radius: 10,
                            width: 81,
                            height: 81,
                          ),
                        )
                      : ContainerIcon(
                          width: 81,
                          height: 81,
                          color: AppColors.color_F3F7ED,
                          radius: 10,
                          image: 'profileadd',
                          onPressed: () {
                            WidgetUtil.showUploadImageOperations(context,
                                () async {
                              if (await PermissionsUtil
                                  .requestCameraPermission()) {
                                userConroller.updateAvatar(false);
                              }
                            }, () async {
                              if (await PermissionsUtil
                                  .requestStoragePermission()) {
                                userConroller.updateAvatar(true);
                              }
                            });
                          },
                        ),
                ),
                const SizedBox(height: 11),
                 TextWidget(
                  text: 'Upload Profile Image'.tr,
                  color: AppColors.color_1A342B,
                  weight: FontWeight.w600,
                  size: 14,
                ),
                const SizedBox(height: 35),
                const Divider(height: 1),
                Obx(() {
                  final genders = controller.signupFlow.genderEnum ?? [];
                  final gender = genders
                      .singleWhere((e) => userConroller.gender == e.value,
                          orElse: () => EnumModel())
                      .text;
                  final heightUnits = controller.signupFlow.tallUnitEnum ?? [];
                  final heightUnit = heightUnits
                      .singleWhere((e) => userConroller.heightUnit == e.value,
                          orElse: () => EnumModel())
                      .text;
                  final weightUnits = controller.signupFlow.weightUnitEnum ?? [];
                  final weightUnit = weightUnits
                      .singleWhere((e) => userConroller.weightUnit == e.value,
                          orElse: () => EnumModel())
                      .text;
                  var map = {
                    'User Name'.tr: userConroller.username,
                    'Age'.tr: '${userConroller.age}',
                    'Gender'.tr: gender ?? '',
                    'Height'.tr: '${userConroller.height} ${heightUnit ?? ''}',
                    'Weight'.tr: '${userConroller.weight} ${weightUnit ?? ''}',
                    'Allergies'.tr: '',
                  };
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: map.keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      var key = map.keys.elementAt(index);
                      var name = map[key];
                      return ProfileItem(
                          subTitle: name ?? '',
                          title: key,
                          arrow: 'assets/svg/merightarrow.svg',
                          isHideSubTitle: index == 5 ? true : false,
                          isHideArrow:
                              (index == 1 || index == 2) ? true : false,
                          onTap: () {
                            debugPrint('index==$index');
                            if (index == 0) {
                              Get.to(const MeUserNamePage());
                            } else if (index == 3) {
                              Get.to(MeHeightPage());
                            } else if (index == 4) {
                              Get.to(MeWeightPage());
                            } else if (index == 5) {
                              Get.to(MeAllergiesPage());
                            }
                          });
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
