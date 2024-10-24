import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/custom/profile_item.dart';
import 'package:unitaapp/common/index.dart';

import '../../../common/routers/names.dart';
import '../../../common/services/auth_service.dart';

class NotificationPage extends GetView<NotificationPageController> {
  @override
  Widget build(BuildContext context) {
    Get.put(NotificationPageController());
    return Scaffold(
      appBar: appBar(title: 'Notification'.tr),
      body: Column(
        children: [
          Obx(() => controller.pushNotifiRx.value
              ? SizedBox.shrink()
              : _buildNotificationOFFHint()),
          Flexible(
              child: Obx(() => ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    itemCount: controller.notifiRxList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => _buildNotificationItem(
                          controller.notifiRxList[index]));
                    },
                    separatorBuilder: (_, index) => Divider(),
                  )))
        ],
      ),
    );
  }

  Widget _buildNotificationOFFHint() => Column(
        children: [
          Container(
            margin: EdgeInsets.all(14.w),
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
                color: AppColors.color_F8EFE9,
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
                      text: 'Turn on Notification in your device settings'.tr,
                      size: 16,
                      weight: FontWeight.w500,
                      color: AppColors.color_1A342B,
                    ),
                    SizedBox(height: 10),
                    TextWidget(
                        text:
                            'Notifications help you stay on track and stay connected with your UniBot.'.tr,
                        softWrap: true,
                        maxLines: null,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.color_456C51)),
                  ],
                ))
              ],
            ),
          ),
          Divider(endIndent: 14.w, indent: 14.w),
        ],
      );

  Widget _buildNotificationItem(Map data) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: Obx(() => TextWidget(
                          text: data['title'].value,
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: AppColors.color_1A342B,
                        ))),
                Switch.adaptive(
                    value: data['enable'].value ?? false,
                    onChanged: data['onValueChanged']),
              ],
            ),
            TextWidget(
                text: data['desc'],
                maxLines: null,
                softWrap: true,
                style: GoogleFonts.openSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color_456C51)),
            15.verticalSpace,
          ],
        ),
      );
}

class NotificationPageController extends GetxController {
  RxBool pushNotifiRx = false.obs;
  RxString pushNotifiTitleRx = 'Push Notification are OFF'.tr.obs;
  RxBool newsEmailRx = false.obs;
  RxBool marketingEmailRx = false.obs;

  RxList notifiRxList = [].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
    notifiRxList = [
      {
        'title': pushNotifiTitleRx,
        'desc':
            'We’ll help you stay on track by sending you reminders to complete your Gut Track and notifying you when your UniBot messages you.'.tr,
        'enable': pushNotifiRx,
        'onValueChanged': (bool value) {
          pushNotifiRx.value = value;
          pushNotifiTitleRx.value = 'Push Notification are ON/OFF'.trArgs([(value ? 'ON' : 'OFF')]);

          saveNotifications();
        }
      },
      {
        'title': 'News & Update Emails'.tr.obs,
        'desc': 'We’ll email you updates about programs and features.'.tr,
        'enable': newsEmailRx,
        'onValueChanged': (bool value) {
          newsEmailRx.value = value;
          saveNotifications();
        }
      },
      {
        'title': 'Marketing Emails'.tr.obs,
        'desc':
            'Science-backed gastro tips, recipes, gut health lifestyle advice and more right to your inbox from out UniBot.'.tr,
        'enable': marketingEmailRx,
        'onValueChanged': (bool value) {
          marketingEmailRx.value = value;
          saveNotifications();
        }
      },
    ].obs;
  }

  Future<void> saveNotifications() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('MARKETING_EMAIL', marketingEmailRx.value);
    await sp.setBool('NEWS_EMAIL', newsEmailRx.value);
    await sp.setBool('PUSH_NOTIFICATION', pushNotifiRx.value);
  }

  Future<void> _loadNotifications() async {
    final sp = await SharedPreferences.getInstance();
    marketingEmailRx.value = sp.getBool('MARKETING_EMAIL') ?? false;
    newsEmailRx.value = sp.getBool('NEWS_EMAIL') ?? false;
    pushNotifiRx.value = sp.getBool('PUSH_NOTIFICATION') ?? false;
  }
}
