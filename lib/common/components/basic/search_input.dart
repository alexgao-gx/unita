import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/models/food_model.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class SearchInputWidget<T extends SearchInputController> extends GetView<T> {
  const SearchInputWidget({super.key, this.onValueChanged});
  final ValueChanged<FoodModel?>? onValueChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 61.h,
        alignment: Alignment.center,
        padding:  EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: Colors.white),
        child: DropdownSearch<FoodModel>(
          popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              // constraints: BoxConstraints(maxHeight: 171.h),
              menuProps: MenuProps(
                  elevation: 0.5,
                  shadowColor: Colors.black12,
                  borderRadius: BorderRadius.circular(10.r),
                  positionCallback:
                      (RenderBox popupButtonObject, RenderBox overlay) {
                    // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
                    return RelativeRect.fromSize(
                      Rect.fromPoints(
                        popupButtonObject.localToGlobal(
                            popupButtonObject.size.bottomLeft(Offset(0, -42.h)),
                            ancestor: overlay),
                        popupButtonObject.localToGlobal(
                            popupButtonObject.size
                                .bottomRight(Offset(0, -42.h)),
                            ancestor: overlay),
                      ),
                      Size(overlay.size.width, overlay.size.height),
                    );
                  }),
              searchFieldProps: TextFieldProps(
                  autofocus: true,
                  controller: controller.searchController,
                  // padding: EdgeInsets.symmetric(horizontal: 14.w),
                  padding: EdgeInsets.zero,
                  decoration: _searchInputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.color_E6DCD6, width: 0.5)),
                      contentPadding: EdgeInsets.only(top: 2.h),
                      marginLeft: 14.w,
                      prefixIconConstraints:
                      BoxConstraints(maxHeight: 22.w, maxWidth: 52.w)),),
              isFilterOnline: true,
              showSelectedItems: false,
              showSearchBox: true,
              loadingBuilder: (_, __) => SizedBox(
                  height: 40.h,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  )),
              emptyBuilder: (_, __) => SizedBox(
                    height: 40.h,
                    child: Center(
                      child: TextWidget(
                        text: 'No data found'.tr,
                        size: 14.sp,
                        weight: FontWeight.w400,
                        color: AppColors.color_C5C5C5,
                      ),
                    ),
                  ),
              itemBuilder: (_, food, isSelected) {
                return Obx(() => Container(
                      height: 40.h,
                      margin: EdgeInsets.symmetric(horizontal: 14.w),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: controller.foods.indexOf(food) !=
                                  controller.foods.length - 1
                              ? const Border(
                                  bottom: BorderSide(
                                      color: AppColors.color_E6DCD6,
                                      width: 0.5))
                              : null),
                      child: Row(
                        children: [
                          Visibility(
                              visible: food.code == null,
                              child: IconWidget.svg(
                                size: 16.w,
                                'assets/svg/ico_plus.svg',
                              )),
                          8.horizontalSpace,
                          TextWidget(
                            text: food.name ?? '',
                            size: 14.sp,
                            weight: FontWeight.w500,
                            color: AppColors.color_1A342B,
                          ),
                        ],
                      ),
                    ));
              },
              onDismissed: () {
                controller.searchController.clear();
              }
              // disabledItemFn: (String s) => s.startsWith('I'),
              ),
          asyncItems: (String filter) => controller.searchResults(filter),
          dropdownButtonProps:
              const DropdownButtonProps(icon: SizedBox.shrink()),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: GoogleFonts.fahkwang(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.color_C5C5C5),
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: _searchInputDecoration(
                border: InputBorder.none,
                marginLeft: 14.w,
                contentPadding: EdgeInsets.zero,
                prefixIconConstraints:
                    BoxConstraints(maxHeight: 22.w, maxWidth: 52.w)),

          ),
          onBeforePopupOpening: (_) {
            return Future.value(true);
          },
          onChanged: (food) {
            if (food?.code == null) {
              onValueChanged?.call(food?..code = 'UNKOWN');
            } else {
              onValueChanged?.call(food);
            }
            controller.searchController.clear();
          },
          compareFn: (_, __) {
            return true;
          },
          itemAsString: (food) => 'Search...'.tr,
        ));
  }

  InputDecoration _searchInputDecoration(
          {InputBorder? border,
          double? marginLeft,
          BoxConstraints? prefixIconConstraints,
          EdgeInsets? contentPadding}) =>
      InputDecoration(
          border: border,
          errorBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          contentPadding: contentPadding,
          prefixIcon: Row(
            children: [
              SizedBox(width: marginLeft),
              IconWidget.svg(
                'assets/svg/ico_search.svg',
                size: 22.w,
              ),
              VerticalDivider(
                // width: 15.w,
                thickness: 1,
                indent: 6.h,
                endIndent: 6.h,
                color: AppColors.color_C5C5C5,
              )
            ],
          ),
          // constraints: prefixIconConstraints,
          prefixIconConstraints: prefixIconConstraints,
          hintText: "Search...".tr,
          hintStyle: GoogleFonts.fahkwang(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.color_C5C5C5));
}

mixin SearchInputController on GetLifeCycle {
  late TextEditingController searchController;
  RxList<FoodModel> foods = <FoodModel>[].obs;

  @override
  void onInit() {
    searchController = TextEditingController();
    searchController.addListener(() {
      searchResults(searchController.text);
    });
    super.onInit();
  }

  Future<List<FoodModel>> searchResults(String keywords);

  @override
  void onClose() {
    searchController.dispose();

    super.onClose();
  }
}
