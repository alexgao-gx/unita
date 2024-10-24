import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/search_input.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/food_model.dart';

import '../../api/log_api.dart';
import '../../models/log_model.dart';
import '../../models/log_req_model.dart';
import '../basic/app_bar.dart';
import 'log_beverage_item.dart';
import 'log_date_time.dart';
import 'log_food_counter.dart';

class LogMedicationPage<T extends LogMedicationPageController>
    extends GetView<LogMedicationPageController> {
  LogMedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogMedicationPageController());
    return Scaffold(
      appBar:
          logAppBar(title: 'Med & Supplement'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchMedicationLogInfo();
            }),
            5.verticalSpace,
            SearchInputWidget<T>(
              onValueChanged: (medication) {
                controller.addMedication(
                    controller.medicationsRx,
                    MedicationModel(
                        name: medication?.name,
                        code: medication?.code,
                        servingSize: 1));
              },
            ),
            _buildAllBeveragesView(),
            94.verticalSpace,
          ],
        ).paddingHorizontal(14.w),
      ),
    );
  }

  Widget _buildAllBeveragesView() => GetBuilder(
      id: 'MEDICATIONS_VIEW',
      builder: (LogMedicationPageController controller) => ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = controller.medicationsRx[index];
            final title = item.name ?? '';
            final count = item.servingSize ?? 0;
            return SizedBox(
              height: 49.h,
              child: LogBeverageItemWidget(
                title: title,
                count: count.toInt(),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => LogFoodCounterWidget(
                          title: title,
                          numberValue: '$count',
                          onSaved: (v) {
                            item.servingSize = v;
                            controller.update(['MEDICATIONS_VIEW'], true);
                          },
                          onRemove: () {
                            // 全部移除
                            item.servingSize = 0;
                            controller.update(['MEDICATIONS_VIEW'], true);
                          }));
                },
              ),
            );
          },
          separatorBuilder: (_, __) => 10.verticalSpace,
          itemCount: controller.medicationsRx.length));
}

class LogMedicationPageController extends GetxController
    with SearchInputController {
  Rx<DateTime> dateRx = DateTime.now().obs;
  RxList<MedicationModel> medicationsRx = <MedicationModel>[].obs;

  @override
  void onInit() {
    fetchMedicationLogInfo();
    super.onInit();
  }

  Future<void> fetchMedicationLogInfo() async {
    final logInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.MED], logDate: dateRx.value);
    medicationsRx.value = logInfo.medInfo?.medInfo ?? <MedicationModel>[];
    update(['MEDICATIONS_VIEW'], true);
  }

  Future<void> onSaveAll() async {
    final medications = medicationsRx
        .where((med) => med.servingSize != null && med.servingSize! > 0)
        .toList();
    await LogAPI.saveLogInfo(LogReqModel(
        medicationInfo: MedicationInfoReqModel(medicationInfo: medications),
        logType: LogType.MED.name));
    await fetchMedicationLogInfo();
    Get.back();
  }

  void addMedication(
      RxList<MedicationModel> medications, MedicationModel? medication) {
    final sameMedications =
        medications.where((e) => e.name == medication?.name);
    if (sameMedications.isNotEmpty) {
      num servingSize = sameMedications.first.servingSize ?? 1;
      sameMedications.first.servingSize = servingSize + 1;
    } else {
      medications.add(MedicationModel(
          code: medication?.code, name: medication?.name, servingSize: 1));
    }
    update(['MEDICATIONS_VIEW'], true);
  }

  @override
  Future<List<FoodModel>> searchResults(String keywords) async {
    if (keywords.isEmpty) {
      return <FoodModel>[];
    }
    final resp = await LogAPI.searchMedication(keywords);
    final foods = resp
        .map((e) => FoodModel(name: e.name, code: e.code))
        .toList();
    final results = foods.where((e) => e.name == keywords);
    if (results.isEmpty) {
      foods.add(FoodModel(name: keywords));
    }

    return foods;
  }
}
