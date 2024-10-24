import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitaapp/common/components/custom/log_food_page.dart';
import 'package:unitaapp/common/components/custom/log_bowelmovement_page.dart';
import 'package:unitaapp/common/components/custom/log_how_to_complete_dialog.dart';
import 'package:unitaapp/common/components/custom/log_medication_page.dart';
import 'package:unitaapp/common/components/custom/log_period_page.dart';
import 'package:unitaapp/common/components/custom/log_skin_page.dart';
import 'package:unitaapp/common/components/custom/log_symptoms_page.dart';
import 'package:unitaapp/common/components/custom/log_wellness_health_page.dart';

import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/widgets/index.dart';
import 'package:unitaapp/pages/log/log_order_page.dart';

class LogPage extends GetView<LogPageController> {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogPageController());
    return GetBuilder(
        id: 'LOG_PAGE_VIEW',
        builder: (LogPageController controller) => Scaffold(
              body: IndexedStack(
                  index: controller.index.value,
                  children: controller.pageListRx),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(top: 19.h),
                height: 113.h,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: AppColors.color_E6DCD6, width: 0.5)),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.pageListRx.length,
                  itemBuilder: (BuildContext context, int index) {
                    String imgName = controller.pageIconsRx[index];
                    String selName = imgName;
                    if (index < controller.pageIconsRx.length - 1) {
                      selName = imgName.replaceAll('nor', 'sel');
                    }
                    return UnconstrainedBox(
                      alignment: Alignment.topCenter,
                      constrainedAxis: Axis.horizontal,
                      child: InkWell(
                        onTap: () async {
                          controller.index.value = index;
                          if (index !=
                              controller.pageListRx.length - 1) {
                            final page = controller.pageListRx[index];
                            if (page is LogFoodPage) {
                              page.controller.fetchLogInfo();
                            } else if (page
                                is LogBowelMovementPage) {
                              page.controller.fetchBMLogInfo();
                            } else if (page is LogSymptomsPage) {
                              page.controller.fetchSymptomsLogInfo();
                            } else if (page
                                is LogWellnessHealthPage) {
                              page.controller.fetchWellnessHealthLogInfo();
                            } else if (page is LogSkinPage) {
                              page.controller.fetchSkinLogInfo();
                            } else if (page is LogMedicationPage) {
                              page.controller.fetchMedicationLogInfo();
                            } else if (page is LogPeriodPage) {
                              page.controller.fetchPeriodLogInfo();
                            }
                          }
                          controller.update(['LOG_PAGE_VIEW'], true);
                        },
                        child: index == controller.pageIconsRx.length - 1
                            ? IconWidget.svg(
                                'assets/svg/ico_more.svg',
                                size: 48.w,
                              )
                            : Obx(() {
                                return Container(
                                  width: 48.w,
                                  height: 48.w,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24.w),
                                    border: Border.all(
                                        width: index == controller.index.value
                                            ? 2
                                            : 1,
                                        color: index == controller.index.value
                                            ? AppColors.color_65AF7C
                                            : AppColors.color_B5C2B3),
                                  ),
                                  child: IconWidget.svg(
                                      size: 30.w,
                                      index == controller.index.value
                                          ? 'assets/svg/$selName'
                                          : 'assets/svg/$imgName'),
                                );
                              }),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => 10.horizontalSpace,
                ),
              ),
            ));
  }
}

class LogPageController extends GetxController {
  RxInt index = 0.obs;
  RxList<LogPageModel> pageModelsRx = <LogPageModel>[].obs;


  @override
  void onInit() {
    _loadOrder();
    super.onInit();
  }


  RxList<Widget> get pageListRx {
    List<LogPageModel> visiblePageModels =
        pageModelsRx.where((e) => e.visibility == true).toList();
    List<Widget> newList = List.from(
        visiblePageModels.map((pageModel) => pageModel.page).toList());
    newList.add(LogOrderPage());
    return newList.obs;
  }

  RxList<String> get pageIconsRx {
    List<LogPageModel> visiblePageModels =
        pageModelsRx.where((e) => e.visibility == true).toList();
    List<String> newList = List.from(
        visiblePageModels.map((pageModel) => pageModel.pageIcon).toList());
    newList.add('ico_more.svg');
    return newList.obs;
  }

  RxList<String> get pageNamesRx {
    List<LogPageModel> visiblePageModels =
        pageModelsRx.where((e) => e.visibility == true).toList();
    List<String> newList = List.from(
        visiblePageModels.map((pageModel) => pageModel.pageName).toList());
    return newList.obs;
  }

  List<Widget> _pageList = [
    LogFoodPage(),
    LogBowelMovementPage(),
    LogSymptomsPage(),
    LogWellnessHealthPage(),
    LogSkinPage(),
    LogMedicationPage(),
    LogPeriodPage(),
  ];

  List<String> _pageIcons = [
    'ico_dietary_nor.svg',
    'ico_bowel movement_nor.svg',
    'ico_symptoms_nor.svg',
    'ico_wellness_nor.svg',
    'ico_skin_nor.svg',
    'ico_medication_nor.svg',
    'ico_period_nor.svg'
  ];

  List<String> _pageNames = [
    'Food & Drink'.tr,
    'Bowel Movement'.tr,
    'Symptoms'.tr,
    'Wellness & Health'.tr,
    'Skin'.tr,
    'Medication'.tr,
    'Period'.tr,
  ];

  Future<void> saveOrder() async {
    final sp = await SharedPreferences.getInstance();
    final spCaches = pageModelsRx.map((e) => jsonEncode(e.toJson())).toList();
    await sp.setStringList('LOG_PAGES', spCaches);
    update(['LOG_PAGE_VIEW'], true);
    Loading.toast('Operation successful'.tr);
    index.value = pageNamesRx.length;
  }

  Future<void> _loadOrder() async {
    final sp = await SharedPreferences.getInstance();
    final spCaches = sp.getStringList('LOG_PAGES');
    if (spCaches != null) {
      pageModelsRx.value = spCaches.map((e) {
        final logPageModel = LogPageModel.fromJson(jsonDecode(e));
        logPageModel.pageIcon = _pageIcons[int.parse('${logPageModel.id}')];
        logPageModel.pageName = _pageNames[int.parse('${logPageModel.id}')];
        logPageModel.page = _pageList[int.parse('${logPageModel.id}')];

        return logPageModel;
      }).toList();
    } else {
      pageModelsRx.value = _pageNames.map((e) {
        final index = _pageNames.indexOf(e);
        final logPageModel = LogPageModel(pageName: e);
        logPageModel.pageIcon = _pageIcons[index];
        logPageModel.id = index;
        logPageModel.page = _pageList[index];
        logPageModel.visibility = true;
        return logPageModel;
      }).toList();
    }
    update(['LOG_PAGE_VIEW'], true);
  }
}

class LogPageModel {
  bool? visibility;
  int? id;
  String? pageName;
  String? pageIcon;
  Widget? page;

  LogPageModel(
      {this.visibility,
      this.id,
      this.pageName,
      this.pageIcon,
      this.page});

  LogPageModel.fromJson(Map<String, dynamic> json) {
    visibility = json['visibility'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visibility'] = this.visibility;
    data['id'] = this.id;
    return data;
  }
}
