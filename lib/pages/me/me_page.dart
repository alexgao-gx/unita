import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/custom/me_header.dart';
import 'package:unitaapp/common/components/custom/me_setting_item.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/utils/widget_util.dart';
import 'package:unitaapp/pages/me/me_about_page.dart';
import 'package:unitaapp/pages/me/me_assessment_page.dart';
import 'package:unitaapp/pages/me/me_policy_page.dart';
import 'package:unitaapp/pages/me/me_profile_page.dart';

import '../../common/routers/names.dart';
import '../../common/services/auth_service.dart';

class MePage extends StatelessWidget {
  MePage({super.key});
  var map = {
    'Profile'.tr: 'assets/svg/ico_bottom_me_sel.svg',
    // 'Assessment'.tr: 'assets/svg/meassessment.svg',
    'Reports'.tr: 'assets/svg/ico_Report.svg',
    // 'Community': 'assets/svg/ico_community.svg',
    'Shopping Cart'.tr: 'assets/svg/ico_shopping_cart.svg',
    // 'Physician Certification': 'assets/svg/ico_PhysicianCertification.svg',
    'Setting'.tr: 'assets/svg/ico_setting.svg',
    'Refer My Friends'.tr: 'assets/svg/ico_Share.svg',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MeHeader(),
            const Divider(height: 1),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: map.keys.length,
              itemBuilder: (BuildContext context, int index) {
                var key = map.keys.elementAt(index);
                var imageName = map[key];
                return MeSettingItem(
                    iconName: imageName!,
                    title: key,
                    arrow: 'assets/svg/merightarrow.svg',
                    iconSize: index == 1 ? 18.r : 20.r,
                    onTap: () {
                      debugPrint('index==$index');
                      if (index == 0) {
                        Get.toNamed(RouteNames.profile);
                      } else if (index == 1) {
                        Get.toNamed(RouteNames.reports);
                      } else if (index == 2) {
                        Get.toNamed(RouteNames.shoppingCart);
                      } else if (index == 3) {
                        Get.toNamed(RouteNames.settings);
                      } else if (index == 4) {
                        WidgetUtil.showGallery(
                            context,
                            [
                              'https://images.pexels.com/photos/3490348/pexels-photo-3490348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
                            ],
                            0);
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
