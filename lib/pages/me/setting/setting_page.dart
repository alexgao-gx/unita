import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/custom/profile_item.dart';

import '../../../common/routers/names.dart';
import '../../../common/services/auth_service.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Setting'.tr),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        itemCount: listMap.keys.length,
        itemBuilder: (BuildContext context, int index) {
          return ProfileItem(
              subTitle: '',
              height: 59.h,
              titleTextSize: 16.sp,
              title: listMap.keys.toList()[index],
              arrow: 'assets/svg/merightarrow.svg',
              isHideSubTitle: true,
              isHideArrow: false,
              onTap: listMap.values.toList()[index]);
        },
      ),
    );
  }

  Map<String, VoidCallback> get listMap => {
        'Notification'.tr: () {
          Get.toNamed(RouteNames.notification);
        },
        'Billing & Subscription'.tr: () {
          Get.toNamed(RouteNames.billingAndSubscription);
        },
        'FAQs'.tr: () {},
        'Contact Us'.tr: () {
          Get.toNamed(RouteNames.contactUs);
        },
        'Terms & Conditions'.tr: () {},
        'Privacy Policy'.tr: () {},
        'Log Out'.tr: () {
          final authServiece = Get.find<AuthService>();
          authServiece.logout();
          Get.offAllNamed(RouteNames.signUp);
        },
      };
}
