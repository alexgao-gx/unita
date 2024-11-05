import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/api/auth_api.dart';
import 'package:unitaapp/common/components/custom/log_bm_appearances.dart';
import 'package:unitaapp/common/components/custom/log_bm_history_edit.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/log_model.dart';
import 'package:unitaapp/common/models/signup_flow_model.dart';

import '../../api/log_api.dart';
import '../../models/log_req_model.dart';
import '../../utils/hive_box.dart';
import '../basic/app_bar.dart';
import 'log_bm_shape.dart';
import 'log_date_time.dart';

class LogBowelMovementPage extends GetView<LogBowelMovementPageController> {
  LogBowelMovementPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogBowelMovementPageController());
    return Scaffold(
      appBar:
          logAppBar(title: 'Bowel Movement'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchBMLogInfo();
            }),
            Obx(() => LogBmShapeWidget(
                  shapeIcons: controller.bmShapeIcons,
                  shapes: controller.bmShapesRx.value,
                  onShapeChanged: (EnumModel shape, int shapeIndex) {
                    controller.bmReqModel.value.shape =
                        int.tryParse(shape.value ?? '1');
                  },
                )),
            40.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  datas: controller.bmAppearancesRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.bmReqModel.value.apperance = v.value ?? v.text;
                  },
                )),
            28.verticalSpace,
            GetBuilder(
                id: 'POOP_HISTORY_VIEW',
                builder: (LogBowelMovementPageController controller) =>
                    _buildPoopHistories()),
            42.verticalSpace,
            TextWidget(
              text: 'Color'.tr,
              color: AppColors.color_1A342B,
              weight: FontWeight.w500,
              size: 16.sp,
            ).paddingHorizontal(14.w),
            SizedBox(
              height: 16.h,
            ),
            _buildBMColors(),
            SizedBox(height: 55.h),
            TextWidget(
              text: 'Feeling during defecation'.tr,
              color: AppColors.color_1A342B,
              weight: FontWeight.w500,
              size: 16.sp,
            ).paddingHorizontal(14.w),
            25.verticalSpace,
            Obx(() => LogBmAppearancesWidget(
                  datas: controller.bmFeelingsRx.value,
                  onBmAppearanceChanged: (v) {
                    controller.bmReqModel.value.feeling = v.value ?? v.text;
                  },
                )),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildPoopHistories() {
    List<Widget> widgets = List.generate(
        controller.bmInfoRx.value.length,
        (index) => _buildHistoryCard(controller.bmInfoRx[index],
            index == controller.bmInfoRx.length - 1));
    var placeholder = Container(
      height: 30.h,
      decoration: BoxDecoration(color: AppColors.color_65AF7C),
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: AppColors.color_FFFCF5,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.h)),
        ),
      ),
    );
    if (widgets.isNotEmpty) {
      widgets.insert(0, placeholder);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }

  Widget _buildHistoryCard(BowelMovementInfo history, bool isLast) {
    return Builder(
        builder: (context) => CustomPaint(
              foregroundPainter: isLast ? null : BmHistoryPainter(),
              child: GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      scrollControlDisabledMaxHeightRatio: 0.8,
                      builder: (_) => LogBmHistoryEdit(history: history));
                  Get.delete<LogBmHistoryEditController>(
                      tag: history.id.toString());
                },
                child: Container(
                  height: 51.h,
                  decoration: BoxDecoration(
                      color: AppColors.color_65AF7C,
                      borderRadius: isLast
                          ? BorderRadius.vertical(bottom: Radius.circular(30.r))
                          : null),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: 'Poop History | log time'
                            .trArgs(['${history.logTime}']),
                        style: GoogleFonts.openSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color_FFFCF5,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppColors.color_FFFCF5, size: 12.w),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildBMColors() => GetBuilder(
      id: 'BM_COLORS',
      builder: (LogBowelMovementPageController controller) => GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 每行6个图标
              mainAxisSpacing: 26.w, // 主轴间距
              crossAxisSpacing: 12.h, // 交叉轴间距
              childAspectRatio: 1,
            ),
            itemCount: controller.bmColorsRx.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.bmColorsRx[index];
              Color color = Color(int.parse('0x${item.color}'));
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  controller.bmColorsRx.forEach(
                      (v) => v.isSelected.value = v.color == item.color);
                  controller.update(['BM_COLORS']);
                },
                child: UnconstrainedBox(
                  child: Container(
                    height: 22.w,
                    width: 22.w,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                          color: AppColors.color_C1E1CE, // 边框颜色
                          width: item.isSelected.value ? 5.r : 0, // 边框宽度
                          strokeAlign: BorderSide.strokeAlignOutside),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                ),
              );
            },
          ));
}

class LogBowelMovementPageController extends GetxController {
  List<String> bmShapeIcons = [
    'assets/svg/img_lacking_fibre_sel.svg',
    'assets/svg/img_mild_diarrhoea_sel.svg',
    'assets/svg/img_mild_onstipation_sel.svg',
    'assets/svg/img_normal_cracked_sel.svg',
    'assets/svg/img_normal_smooth_sel.svg',
    'assets/svg/img_servere_diarrhoea_sel.svg',
    'assets/svg/img_severe_constipation_sel.svg',
  ];

  RxList<BowelMovementInfo> bmInfoRx = <BowelMovementInfo>[].obs;
  Rx<DateTime> dateRx = DateTime.now().obs;
  RxList<EnumModel> bmShapesRx = <EnumModel>[].obs;

  RxList<EnumModel> bmAppearancesRx = <EnumModel>[].obs;
  RxList<EnumModel> bmColorsRx = <EnumModel>[].obs;
  RxList<EnumModel> bmFeelingsRx = <EnumModel>[].obs;
  Rx<BowelMovementInfo> bmReqModel = BowelMovementInfo().obs;

  @override
  void onInit() {
    fetchBMLogInfo();
    super.onInit();
  }

  Future<void> fetchBMLogInfo() async {
    await _fetchBMShapes();

    // Retrieve userinfo.id from HiveBox
    String userId = HiveBox.user.getUser().id.toString();

    final bmInfo = await LogAPI.fetchLogInfo(
      logTypes: [LogType.BOWEL_MOVEMENT],
      logDate: dateRx.value,
      userId: userId, // Pass userId here
    );
    bmInfoRx.value = bmInfo.bowelMovementInfo ?? <BowelMovementInfo>[];
    update(['POOP_HISTORY_VIEW'], true);
  }

  Future<void> _fetchBMShapes() async {
    final resp = await AuthAPI.fetchSignupFlows(
        ['BmShapeEnum', 'BmApperanceEnum', 'BmColorEnum', 'BmFeelEnum']);
    bmShapesRx.value = resp.bmShapeEnum ?? <EnumModel>[].obs;
    bmColorsRx.value = resp.bmColorEnum ?? <EnumModel>[].obs;
    if (bmColorsRx.isNotEmpty) {
      bmColorsRx.first.isSelected = true.obs;
    }
    bmAppearancesRx.value = resp.bmApperanceEnum ?? <EnumModel>[].obs;
    bmFeelingsRx.value = resp.bmFeelEnum ?? <EnumModel>[].obs;
    update(['BM_COLORS'], true);
  }

  Future<void> onSaveAll() async {
    final color = bmColorsRx.singleWhere((e) => e.isSelected.value == true,
        orElse: () => EnumModel());
    final shape = bmShapesRx.singleWhere((e) => e.isSelected.value == true,
        orElse: () => EnumModel());

    // Retrieve userinfo.id from HiveBox
    String userId = HiveBox.user.getUser().id.toString();

    await LogAPI.saveLogInfo(
      LogReqModel(
        bowelMovementInfo: bmReqModel.value
          ..color = color.value
          ..shape = int.tryParse(shape.value ?? '0'),
        logType: LogType.BOWEL_MOVEMENT.name,
        userId: userId, // Include userId if needed in request payload
      ),
    );
    bmReqModel.value.apperance = null;
    bmReqModel.value.feeling = null;

    await fetchBMLogInfo();

    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class BmHistoryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = AppColors.color_D9D9D9
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final double curveHeight = 30.r;
    final Path path = Path();

    // Starting point on the left
    path.moveTo(0, rect.bottom - curveHeight);
    // First curve
    path.quadraticBezierTo(0, rect.bottom, curveHeight, rect.bottom);
    // Line to the right side
    path.lineTo(rect.right - curveHeight, rect.bottom);
    // Second curve
    path.quadraticBezierTo(
        rect.right, rect.bottom, rect.right, rect.bottom - curveHeight);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
