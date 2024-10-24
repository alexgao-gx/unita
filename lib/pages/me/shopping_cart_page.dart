import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';

class ShoppingCartPage extends GetView<ShoppingCartPageController> {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShoppingCartPageController());
    return Scaffold(
      appBar: appBar(title: 'Shopping Cart'.tr),
      body: GetBuilder(
        id: 'SHOPPING_PAGE_VIEW',
        builder: (ShoppingCartPageController controller) => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            itemBuilder: (_, index) =>
                _buildShoppingCartItem(controller.carts[index]),
            separatorBuilder: (_, __) => 8.verticalSpace,
            itemCount: controller.carts.length),
      ),
      bottomNavigationBar: _buildCheckOutBottomBar(),
    );
  }

  Widget _buildShoppingCartItem(ShoppingCartModel data) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            padding: EdgeInsets.fromLTRB(0, 14.h, 20.w, 14.h),
            decoration: BoxDecoration(
                color: AppColors.color_F3F7ED,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              children: [
                Radio(
                    value: data.isSelected.value,
                    groupValue: true,
                    toggleable: true,
                    onChanged: (v) {
                      data.isSelected.value = !data.isSelected.value;
                      controller.update(['SHOPPING_PAGE_VIEW'], true);
                    }),
                Container(
                  width: 98.w,
                  height: 98.w,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/herbbg.png'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                14.horizontalSpace,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextWidget(
                      text: data.title ?? '',
                      color: AppColors.color_1A342B,
                      size: 16.sp,
                      weight: FontWeight.w600,
                      maxLines: null,
                      softWrap: true,
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: TextWidget(
                          text: '\$ ${data.price ?? 0}',
                          color: AppColors.color_65AF7C,
                          size: 18.sp,
                          weight: FontWeight.w600,
                        )),
                        CustomStepper(
                            initialCount: data.count,
                            onValueChanged: (count) {
                              data.count = count;
                              controller.update(['SHOPPING_PAGE_VIEW'], true);
                            })
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                    color: AppColors.color_65AF7C,
                    borderRadius: BorderRadius.circular(12.r)),
                child: TextWidget(
                  text: 'PRE-ORDER'.tr,
                  style: GoogleFonts.openSans(
                    color: AppColors.color_FFFCF5,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCheckOutBottomBar() {
    return GetBuilder(
      id: 'SHOPPING_PAGE_VIEW',
      builder: (ShoppingCartPageController controller) => Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors.color_E6DCD6, width: 0.5)),
          ),
          child: SafeArea(
              child: Row(
            children: [
              TextWidget(
                text: 'Total:'.tr,
                style: GoogleFonts.openSans(
                  color: AppColors.color_1A342B,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: Obx(() => TextWidget(
                      text: '\$ ${controller.totalPriceRx.value}',
                      color: AppColors.color_65AF7C,
                      size: 18.sp,
                      weight: FontWeight.w600,
                    )),
              ),
              Obx(() => CupertinoButton(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.color_65AF7C,
                  disabledColor: AppColors.color_65AF7C.withOpacity(0.5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  onPressed: controller.checkOrderEnableRx.value ? () {} : null,
                  child: TextWidget(
                    text: 'Check Out'.tr,
                    color: AppColors.color_FCF8F1,
                    size: 16.sp,
                    weight: FontWeight.w600,
                  )))
            ],
          ))),
    );
  }
}

class ShoppingCartPageController extends GetxController {
  RxList<ShoppingCartModel> carts = [
    ShoppingCartModel(
        title: 'Honey Chrysanthemum Wolfberry Tea', price: 24.3, count: 2),
    ShoppingCartModel(
        title: 'Honey Chrysanthemum Wolfberry Tea', price: 12.6, count: 1)
  ].obs;

  Rx<num> get totalPriceRx {
    final selectedModels = carts.where((p) => p.isSelected.value == true);
    final selectedPrice =
        selectedModels.map((e) => (e.price ?? 0) * (e.count ?? 1));
    if (selectedPrice.isNotEmpty) {
      return selectedPrice.reduce((value, element) => value + element).obs;
    } else {
      return 0.obs;
    }
  }

  RxBool get checkOrderEnableRx => (totalPriceRx.value > 0).obs;
}

class ShoppingCartModel {
  String? title;
  num? price;
  int? count;
  RxBool isSelected = true.obs;
  ShoppingCartModel({this.title, this.price, this.count});
}

class CustomStepper extends StatefulWidget {
  final ValueChanged<int>? onValueChanged;
  final int? initialCount;

  const CustomStepper({super.key, this.onValueChanged, this.initialCount});
  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _counter = 1;

  void _increment() {
    setState(() {
      _counter++;
    });
    widget.onValueChanged?.call(_counter);
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
      widget.onValueChanged?.call(_counter);
    }
  }

  @override
  void initState() {
    _counter = widget.initialCount ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 66.w,
        height: 22.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.color_A7998F,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 22.w,
                height: 22.h,
                child: IconButton(
                  iconSize: 12.w,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.remove),
                  alignment: Alignment.center,
                  onPressed: _decrement,
                ),
              ),
              const VerticalDivider(
                color: AppColors.color_A7998F,
                thickness: 0.5,
                width: 0.5,
              ),
              Expanded(
                child: TextWidget(
                  text: '$_counter',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color_1A342B),
                ),
              ),
              const VerticalDivider(
                color: AppColors.color_A7998F,
                thickness: 0.5,
                width: 0.5,
              ),
              SizedBox(
                width: 22.w,
                height: 22.h,
                child: IconButton(
                  iconSize: 12.w,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add),
                  onPressed: _increment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
