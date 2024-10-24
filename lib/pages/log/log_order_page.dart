import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/pages/log/log_page.dart';

import '../../common/components/basic/app_bar.dart';

class LogOrderPage extends GetView<LogPageController> {
  const LogOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: logAppBar(
          title: 'Log Order'.tr,
          logActionText: 'Done'.tr,
          onSave: controller.saveOrder),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextWidget(
              text:
                  'Personalize your daily log by rearranging the order of entries and choosing the items you track. You can even create your own custom log form using our provided template to perfectly suit your needs.'.tr,
              color: AppColors.color_1A342B,
              size: 18.sp,
              weight: FontWeight.w600,
              maxLines: null,
              softWrap: true,
            ).paddingOnly(top: 36.h, left: 14.w, right: 44.w),
            65.verticalSpace,
            Divider(indent: 14.w, endIndent: 14.w),
            GetBuilder(
                id: 'REORDER_LOG_VIEW',
                builder: (LogPageController contrller) => ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: controller.pageModelsRx.map((pageModel) {
                        final pageName = pageModel.pageName ?? '';
                        final visibility = pageModel.visibility ?? true;
                        return Column(
                          key: Key(pageName),
                          children: [
                            ListTile(
                              title: Text(pageName),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.scale(
                                    scale: 0.75,
                                    child: CupertinoSwitch(
                                        activeColor: AppColors.color_C1E1CE,
                                        value: visibility,
                                        onChanged: (v) {
                                          pageModel.visibility =
                                              !(pageModel.visibility ?? true);
                                          contrller.update(
                                              ['REORDER_LOG_VIEW'], true);
                                        }),
                                  ),
                                  IconWidget.svg(
                                    'assets/svg/ico_drag_nor.svg',
                                    width: 30.w,
                                    height: 30.w,
                                  ),
                                ],
                              ),
                            ),
                            Divider(indent: 14.w, endIndent: 14.w, height: 0.5),
                          ],
                        );
                      }).toList(),
                      onReorder: (oldIndex, newIndex) {
                        // 当列表项被重新排序时触发的回调函数

                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }

                        final item = controller.pageModelsRx.removeAt(oldIndex);
                        controller.pageModelsRx.insert(newIndex, item);
                        contrller.update(['REORDER_LOG_VIEW'], true);
                      },
                    )),
            80.verticalSpace,
          ],
        ),
      ),
    );
  }
}
