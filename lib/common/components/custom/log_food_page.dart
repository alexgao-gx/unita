import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unitaapp/common/components/basic/search_input.dart';
import 'package:unitaapp/common/components/custom/log_date_time.dart';
import 'package:unitaapp/common/components/custom/water_tip.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/food_model.dart';
import 'package:unitaapp/common/models/log_req_model.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/pages/home/home_page.dart';
import 'package:unitaapp/pages/log/log_page.dart';

import '../../api/auth_api.dart';
import '../../api/log_api.dart';
import '../../models/log_model.dart';
import '../basic/app_bar.dart';
import 'log_beverage_item.dart';
import 'log_food_counter.dart';
import 'log_food_tab_view.dart';
import 'log_how_to_complete_dialog.dart';
import '../../utils/hive_box.dart';

class LogFoodPage<T extends LogFoodPageController> extends GetView<T> {
  LogFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogFoodPageController());
    return Scaffold(
      appBar: logAppBar(title: 'Food & Drink'.tr, onSave: controller.onSaveAll),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogDateTimeWidget(onDateTimeChanged: (date) {
              controller.dateRx.value = date;
              controller.fetchLogInfo();
            }),
            _buildFoodView(),
            47.verticalSpace,
            Column(
              children: [
                Obx(() => WaterTip(
                      title: 'Beverages'.tr,
                      subTitle: 'Today\'s total beverages intake'.tr,
                      targetValue: 'xx oz'.trArgs(
                          ['${controller.beverageIntakeIconsRx.length * 8}']),
                      icon: 'assets/svg/ico_water_sel.svg',
                      description: '*1 cup = 8 fl oz'.tr,
                    )),
                11.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.color_F3F7ED,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Obx(() => GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(20.w),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8, // 每行6个图标
                          mainAxisSpacing: 10, // 主轴间距
                          crossAxisSpacing: 12, // 交叉轴间距
                          childAspectRatio: 1,
                        ),
                        itemCount: min(
                            max(controller.beverageIntakeIconsRx.length, 16),
                            16),
                        itemBuilder: (BuildContext context, int index) {
                          String imageName;
                          if (index < controller.beverageIntakeIconsRx.length) {
                            imageName = controller.beverageIntakeIconsRx[index];
                          } else {
                            imageName = 'ico_water_nor.svg';
                          }
                          return IconWidget.svg(
                            size: 30.w,
                            'assets/svg/$imageName',
                          );
                        },
                      )),
                ),
              ],
            ),
            _buildAllBeveragesView(),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildFoodView() => GetBuilder(
        id: 'FOODS_VIEW',
        builder: (LogFoodPageController controller) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   height: 35.h,
            //   decoration: TabBarDecoration(tabIndex: controller.tabIndex.value ?? 0),
            //   child: TabBar(
            //     padding: EdgeInsets.zero,
            //     labelPadding: EdgeInsets.zero,
            //     controller: controller.tabController,
            //     labelColor: AppColors.color_65AF7C,
            //     unselectedLabelColor: AppColors.color_1A342B,
            //     indicatorSize: TabBarIndicatorSize.label,
            //     indicatorPadding: EdgeInsets.symmetric(horizontal: 15.w),
            //     indicatorColor: AppColors.color_65AF7C,
            //     indicator: TabBarIndicator(),
            //     labelStyle: GoogleFonts.fahkwang(
            //         fontSize: 16.sp, fontWeight: FontWeight.w700),
            //     unselectedLabelStyle: GoogleFonts.fahkwang(
            //         fontSize: 16.sp, fontWeight: FontWeight.w500),
            //     tabs:  [
            //       Tab(text: 'Breakfast'.tr),
            //       Tab(text: 'Lunch'.tr),
            //       Tab(text: 'Dinner'.tr),
            //       Tab(text: 'Snack'.tr),
            //     ],
            //   ),
            // ),
            FoodTabBarWidget(
              tabTexts: ['Breakfast'.tr, 'Lunch'.tr, 'Dinner'.tr, 'Snack'.tr],
              onTabIndexChanged: (index) {
                controller.tabIndex.value = index;
                controller.update(['FOODS_VIEW'], true);
              },
            ),
            IndexedStack(
              sizing: StackFit.loose,
              index: controller.tabIndex.value,
              children: [
                LogFoodTabView(
                    onValueChanged: (food) {
                      controller.addFood(controller.bFoodsRx, food);
                    },
                    onRemoveFood: (food) {
                      controller.bFoodsRx.remove(food);
                    },
                    onFoodCountUpdated: (food, count) {
                      controller.updateFoodCount(
                          controller.bFoodsRx, food, count);
                    },
                    foods: controller.bFoodsRx),
                LogFoodTabView(
                    onValueChanged: (food) {
                      controller.addFood(controller.lFoodsRx, food);
                    },
                    onRemoveFood: (food) {
                      controller.lFoodsRx.remove(food);
                    },
                    onFoodCountUpdated: (food, count) {
                      controller.updateFoodCount(
                          controller.lFoodsRx, food, count);
                    },
                    foods: controller.lFoodsRx),
                LogFoodTabView(
                    onValueChanged: (food) {
                      controller.addFood(controller.dFoodsRx, food);
                    },
                    onRemoveFood: (food) {
                      controller.dFoodsRx.remove(food);
                    },
                    onFoodCountUpdated: (food, count) {
                      controller.updateFoodCount(
                          controller.dFoodsRx, food, count);
                    },
                    foods: controller.dFoodsRx),
                LogFoodTabView(
                    onValueChanged: (food) {
                      controller.addFood(controller.sFoodsRx, food);
                    },
                    onRemoveFood: (food) {
                      controller.sFoodsRx.remove(food);
                    },
                    onFoodCountUpdated: (food, count) {
                      controller.updateFoodCount(
                          controller.sFoodsRx, food, count);
                    },
                    foods: controller.sFoodsRx),
              ],
            ),
          ],
        ),
      );

  Widget _buildAllBeveragesView() => GetBuilder(
        id: 'ALL_BEVERAGES_VIEW',
        builder: (LogFoodPageController controller) => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.allBeveragesRx[index];
              final title = item.beverageName ?? '';
              final count = int.tryParse(item.servingSize ?? '0') ?? 0;
              return LogBeverageItemWidget(
                title: title,
                count: count,
                iconName: controller.beverageTypeIconsRx[index],
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => LogFoodCounterWidget(
                          title: title,
                          numberValue: '$count',
                          onSaved: (v) {
                            int diff = v - count;
                            if (diff > 0) {
                              // 增加了diff 个icon
                              final icon =
                                  controller.beverageTypeIconsRx[index];
                              if (icon != controller.beverageTypeIconsRx.last) {
                                controller.beverageIntakeIconsRx
                                    .addAll(List.generate(diff, (_) => icon));
                              }
                            } else if (diff < 0) {
                              // 减少了diff 个icon
                              final icon =
                                  controller.beverageTypeIconsRx[index];
                              for (int i = 0; i < diff.abs(); i++) {
                                controller.beverageIntakeIconsRx.remove(icon);
                              }
                            }
                            item.servingSize = '$v';
                            controller.update(['ALL_BEVERAGES_VIEW'], true);
                          },
                          onRemove: () {
                            // 全部移除
                            final icon = controller.beverageTypeIconsRx[index];
                            controller.beverageIntakeIconsRx
                                .removeWhere((e) => icon == e);
                            item.servingSize = '0';
                            controller.update(['ALL_BEVERAGES_VIEW'], true);
                          }));
                },
              );
            },
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemCount: controller.allBeveragesRx.length),
      );
}

class LogFoodPageController extends LogPageController
    with SearchInputController, GetSingleTickerProviderStateMixin {
  Rx<DateTime> dateRx = DateTime.now().obs;

  late TabController tabController = TabController(length: 4, vsync: this);
  RxInt tabIndex = 0.obs;

  /// Gut log foods from data source
  RxList<LogFoodInfo> logFoodsRx = <LogFoodInfo>[].obs;
  RxList<FoodInfo> bFoodsRx = <FoodInfo>[].obs;
  RxList<FoodInfo> lFoodsRx = <FoodInfo>[].obs;
  RxList<FoodInfo> dFoodsRx = <FoodInfo>[].obs;
  RxList<FoodInfo> sFoodsRx = <FoodInfo>[].obs;
  RxList<BeveragesInfo> allBeveragesRx = <BeveragesInfo>[].obs;

  RxList<String> beverageIntakeIconsRx =
      List.generate(16, (_) => 'ico_water_nor.svg').obs;

  RxList<String> beverageTypeIconsRx = <String>[
    'ico_water_sel.svg',
    'ico_tea_sel.svg',
    'ico_coffee_sel.svg',
    'ico_soda_sel.svg',
    'ico_sparkling_sel.svg',
    'ico_juice_sel.svg',
    'ico_alcohol_sel.svg',
  ].obs;

  @override
  void onInit() {
    fetchLogInfo();
    tabController.addListener(() {
      tabIndex.value = tabController.index;
      update(['FOODS_VIEW'], true);
    });
    super.onInit();
  }

  Future<void> fetchLogInfo() async {
    final logInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.FOOD], logDate: dateRx.value);
    logFoodsRx.value = logInfo.logFoodInfo ?? <LogFoodInfo>[];
    bFoodsRx.value = logFoodsRx
            .singleWhere((e) => e.foodMeal == 'B', orElse: () => LogFoodInfo())
            .foodInfo
            ?.toList() ??
        <FoodInfo>[];
    lFoodsRx.value = logFoodsRx
            .singleWhere((e) => e.foodMeal == 'L', orElse: () => LogFoodInfo())
            .foodInfo
            ?.toList() ??
        <FoodInfo>[];
    dFoodsRx.value = logFoodsRx
            .singleWhere((e) => e.foodMeal == 'D', orElse: () => LogFoodInfo())
            .foodInfo
            ?.toList() ??
        <FoodInfo>[];
    sFoodsRx.value = logFoodsRx
            .singleWhere((e) => e.foodMeal == 'S', orElse: () => LogFoodInfo())
            .foodInfo
            ?.toList() ??
        <FoodInfo>[];
    final beveragesLogInfo = await LogAPI.fetchLogInfo(
        logTypes: [LogType.BEVERAGES], logDate: dateRx.value);
    final logBeverages = beveragesLogInfo.beveragesInfo ?? <BeveragesInfo>[];
    await _fetchBeverages(logBeverages);
  }

  void addFood(RxList<FoodInfo> foods, FoodModel? food) {
    final sameFoods = foods.where((e) => e.foodName == food?.name);
    if (sameFoods.isNotEmpty) {
      int servingSize =
          int.tryParse(sameFoods.first.foodServingSize ?? '1') ?? 1;
      sameFoods.first.foodServingSize = '${servingSize + 1}';
      update(['FOODS_VIEW'], true);
    } else {
      foods.add(FoodInfo(
          foodCode: food?.code, foodName: food?.name, foodServingSize: '1'));
    }
  }

  void updateFoodCount(RxList<FoodInfo> foods, FoodInfo food, int count) {
    final sameFoods = foods.where((e) => e.foodName == food.foodName);
    if (sameFoods.isNotEmpty) {
      sameFoods.first.foodServingSize = '$count';
      update(['FOODS_VIEW'], true);
    }
  }

  Future<void> _fetchBeverages(List<BeveragesInfo> logBeverages) async {
    final resp = await AuthAPI.fetchSignupFlows(['BeverageslEnum']);
    allBeveragesRx.value = resp.beverageslEnum?.map((e) {
          BeveragesInfo beverage = logBeverages.singleWhere(
              (v) => v.beverageCode == e.value,
              orElse: () => BeveragesInfo());
          String servingSize = '0';
          if (beverage.beverageCode != null) {
            servingSize = beverage.servingSize ?? '0';
          }
          return BeveragesInfo(
              beverageCode: e.value,
              beverageName: e.text,
              servingSize: servingSize);
        }).toList() ??
        <BeveragesInfo>[];
    update(['ALL_BEVERAGES_VIEW'], true);

    List<String> intakeIcons = <String>[];
    logBeverages.forEach((e) {
      int count = int.tryParse(e.servingSize ?? '0') ?? 0;
      int index =
          allBeveragesRx.indexWhere((v) => v.beverageCode == e.beverageCode);
      String icon = beverageTypeIconsRx[index];
      intakeIcons.addAll(List.generate(count, (_) => icon));
    });
    beverageIntakeIconsRx.value = intakeIcons;
  }

  Future<void> onSaveAll({bool navigateBack = true}) async {
    String userId = HiveBox.user.getUser().userId.toString();
    await LogAPI.saveLogInfo(LogReqModel(
        foodInfo: FoodInfoReqModel(
          breakfastFoodInfo: bFoodsRx,
          lunchFoodInfo: lFoodsRx,
          dinnerFoodInfo: dFoodsRx,
          snackFoodInfo: sFoodsRx,
        ),
        logType: LogType.FOOD.name,
        userId: userId));
    await LogAPI.saveLogInfo(LogReqModel(
        beveragesInfo: allBeveragesRx, logType: LogType.BEVERAGES.name));

    if (Get.isRegistered<HomePageController>()) {
      Get.find<HomePageController>().fetchHomeLogInfo();
      Get.find<UserService>().fetchUserInfo();
    }
    if (navigateBack) {
      Get.back();
    }
  }

  @override
  Future<List<FoodModel>> searchResults(String keywords) async {
    String userId = HiveBox.user.getUser().userId.toString();
    if (keywords.isEmpty) {
      return <FoodModel>[];
    }
    final resp = await LogAPI.searchFoods(keywords,int.parse(userId));
    final results = resp.where((e) => e.name == keywords);
    if (results.isEmpty) {
      resp.add(FoodModel(name: keywords));
    }
    return resp;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class TabBarDecoration extends Decoration {
  final int tabIndex;

  TabBarDecoration({this.tabIndex = 0});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TabBarDecorationPainter(this, onChanged);
  }
}

class _TabBarDecorationPainter extends BoxPainter {
  final TabBarDecoration decoration;
  _TabBarDecorationPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint borderPaint = Paint()
      ..color = AppColors.color_A7998F // 边框颜色
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final Rect rect = offset & configuration.size!;
    const double curveHeight = 15.0;
    final Path path = Path();

    // 绘制带有曲线的边框
    if (decoration.tabIndex == 0) {
      // 左侧起点
      path.moveTo(rect.left, rect.top);
      // 第一个圆弧
      path.lineTo(rect.right / 4 - curveHeight, rect.top);
      path.quadraticBezierTo(
          rect.right / 4, rect.top, rect.right / 4, rect.top + curveHeight);
      // 第二个圆弧
      path.lineTo(rect.right / 4, rect.bottom - curveHeight);
      path.quadraticBezierTo(rect.right / 4, rect.bottom,
          rect.right / 4 + curveHeight, rect.bottom);
      // 右侧终点
      path.lineTo(rect.right, rect.bottom);
    } else if (decoration.tabIndex == 1) {
      // 左侧起点
      path.moveTo(rect.left, rect.bottom);
      // 第一个圆弧
      path.lineTo(rect.right / 4 - curveHeight, rect.bottom);
      path.quadraticBezierTo(rect.right / 4, rect.bottom, rect.right / 4,
          rect.bottom - curveHeight);
      // 第二个圆弧
      path.lineTo(rect.right / 4, rect.top + curveHeight);
      path.quadraticBezierTo(
          rect.right / 4, rect.top, rect.right / 4 + curveHeight, rect.top);
      // 第三个圆弧
      path.lineTo(rect.right / 2 - curveHeight, rect.top);
      path.quadraticBezierTo(
          rect.right / 2, rect.top, rect.right / 2, rect.top + curveHeight);
      // 第四个圆弧
      path.lineTo(rect.right / 2, rect.bottom - curveHeight);
      path.quadraticBezierTo(rect.right / 2, rect.bottom,
          rect.right / 2 + curveHeight, rect.bottom);
      // 右侧终点
      path.lineTo(rect.right, rect.bottom);
    } else if (decoration.tabIndex == 2) {
      // 左侧起点
      path.moveTo(rect.left, rect.bottom);
      // 第一个圆弧
      path.lineTo(rect.right / 2 - curveHeight, rect.bottom);
      path.quadraticBezierTo(rect.right / 2, rect.bottom, rect.right / 2,
          rect.bottom - curveHeight);
      // 第二个圆弧
      path.lineTo(rect.right / 2, rect.top + curveHeight);
      path.quadraticBezierTo(
          rect.right / 2, rect.top, rect.right / 2 + curveHeight, rect.top);
      // 第三个圆弧
      path.lineTo(rect.right * 3 / 4 - curveHeight, rect.top);
      path.quadraticBezierTo(rect.right * 3 / 4, rect.top, rect.right * 3 / 4,
          rect.top + curveHeight);
      // 第四个圆弧
      path.lineTo(rect.right * 3 / 4, rect.bottom - curveHeight);
      path.quadraticBezierTo(rect.right * 3 / 4, rect.bottom,
          rect.right * 3 / 4 + curveHeight, rect.bottom);
      // 右侧终点
      path.lineTo(rect.right, rect.bottom);
    } else {
      // 左侧起点
      path.moveTo(rect.left, rect.bottom);
      // 第一个圆弧
      path.lineTo(rect.right * 3 / 4 - curveHeight, rect.bottom);
      path.quadraticBezierTo(rect.right * 3 / 4, rect.bottom,
          rect.right * 3 / 4, rect.bottom - curveHeight);
      // 第二个圆弧
      path.lineTo(rect.right * 3 / 4, rect.top + curveHeight);
      path.quadraticBezierTo(rect.right * 3 / 4, rect.top,
          rect.right * 3 / 4 + curveHeight, rect.top);
      path.lineTo(rect.right, rect.top);
    }

    canvas.drawPath(path, borderPaint);
  }
}

class TabBarIndicator extends Decoration {
  final Color? indicatorColor;

  TabBarIndicator({this.indicatorColor});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TabBarIndicatorPainter(this, indicatorColor, onChanged);
  }
}

class _TabBarIndicatorPainter extends BoxPainter {
  final TabBarIndicator decoration;
  final Color? indicatorColor;
  _TabBarIndicatorPainter(
      this.decoration, this.indicatorColor, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint underlinePaint = Paint()
      ..color = indicatorColor ?? AppColors.color_65AF7C // 边框颜色
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final Rect rect = offset & configuration.size!;

    // 绘制绿色下划线
    final double lineWidth = 20.w;
    final double lineHeight = 2.h;
    final double lineX = rect.center.dx - lineWidth / 2;
    final double lineY = rect.bottom - lineHeight;

    final Rect lineRect = Rect.fromLTWH(lineX, lineY, lineWidth, lineHeight);
    canvas.drawRRect(RRect.fromRectXY(lineRect, 10, 10), underlinePaint);
  }
}

class FoodTabBarWidget extends StatefulWidget {
  const FoodTabBarWidget(
      {super.key, required this.tabTexts, this.onTabIndexChanged});

  final List<String> tabTexts;
  final ValueChanged<int>? onTabIndexChanged;

  @override
  State<FoodTabBarWidget> createState() => _FoodTabBarWidgetState();
}

class _FoodTabBarWidgetState extends State<FoodTabBarWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: TabBarDecoration(tabIndex: _index),
      child: Row(
        children: widget.tabTexts.map((e) {
          final idx = widget.tabTexts.indexOf(e);
          Color color =
              _index == idx ? AppColors.color_65AF7C : AppColors.color_1A342B;
          FontWeight weight = _index == idx ? FontWeight.w700 : FontWeight.w500;
          return Container(
            decoration: _index == idx ? TabBarIndicator() : null,
            padding: EdgeInsets.only(bottom: 5.h),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _index = idx;
                });
                widget.onTabIndexChanged?.call(_index);
              },
              child: TextWidget(
                text: e,
                color: color,
                weight: weight,
                textAlign: TextAlign.center,
              ),
            ),
          ).expanded();
        }).toList(),
      ),
    );
  }
}
