import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/auth_service.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/pages/home/home_page.dart';
import 'package:unitaapp/pages/log/log_page.dart';
import 'package:unitaapp/pages/me/me_page.dart';
import 'package:unitaapp/pages/plan/plan_page.dart';
import 'package:unitaapp/pages/unibot/unibot_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/components/custom/log_how_to_complete_dialog.dart';
import 'common/i18n/translations.dart';
import 'common/services/service_bindings.dart';
import 'common/services/tab_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
      // splitScreenMode: true, // 支持分屏尺寸
      // minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            initialBinding: ServiceBindings(),
            builder: EasyLoading.init(),
            getPages: RoutePages.pages,
            initialRoute: RouteNames.main,
            translations: UnitaTranslations(),
            supportedLocales:const [
               Locale('en', ''), // English
               Locale('zh', ''), // Chinese
            ],
            localizationsDelegates:const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale:Get.deviceLocale,
            fallbackLocale:const Locale('en', 'US'),
            onReady: () {
              final isLoggedIn = Get.find<AuthService>().isAuth;
              // Use Get.offNamed to navigate to the correct route based on login status
              if (isLoggedIn) {
                Get.offNamed(RouteNames.main);
              } else {
                Get.offNamed(RouteNames.signUp);
              }
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends GetView<TabService> {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TabService());
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomePage(),
              LogPage(),
              UnibotPage(),
              const PlanPage(),
              MePage(),
            ],
          )),
      bottomNavigationBar: ConvexAppBar(
        elevation: 0.1,
        height: 56.h,
        backgroundColor: AppColors.color_FFFCF5,
        color: AppColors.color_B5C2B3,
        activeColor: AppColors.color_456C51,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(
              icon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_home_nor.svg',
              ),
              activeIcon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_home_sel.svg',
              ),
              title: 'Home'.tr),
          TabItem(
              icon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_log_nor.svg',
              ),
              activeIcon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_add.svg',
              ),
              title: 'Log'.tr),
           TabItem(
              icon: ImageWidget.asset(
                'assets/images/tab_bot.png',
              ),
              title: 'Unibot'.tr),
          TabItem(
              icon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_plan_nor.svg',
              ),
              activeIcon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_plan_sel.svg',
              ),
              title: 'Plan'.tr),
          TabItem(
              icon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_me_nor.svg',
              ),
              activeIcon: IconWidget.svg(
                size: 30,
                'assets/svg/ico_bottom_me_sel.svg',
              ),
              title: 'Me'.tr),
        ],
        onTabNotify: (i) {
          if (i == 1) {
            Get.toNamed(RouteNames.log);
            SharedPreferences.getInstance().then((sp) {
              final howToComplete =
                  sp.getBool(Constants.logHowToComplete) ?? true;
              if (howToComplete) {
                Get.dialog(const LogHowToCompleteDialog());
                sp.setBool(Constants.logHowToComplete, false);
              }
            });
          }
          return i != 1;
        },
        onTap: (int i) async {
          if (i == 1) {
          } else if (i == 2) {
            Get.toNamed(RouteNames.unibot);
          } else {
            if (i == 3) {
              if (Get.isRegistered<PlanPageController>()) {
                Get.find<PlanPageController>().fetchPlanInfo();
              }
            }
            controller.tabIndex.value = i;
          }
        },
      ),
    );
  }
}
