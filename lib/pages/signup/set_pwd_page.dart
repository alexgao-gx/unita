import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/container_text_icon.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/pages/signup/set_nickname_page.dart';

class SetPwdPage extends StatefulWidget {
  const SetPwdPage({super.key});

  @override
  State<SetPwdPage> createState() => _SetPwdPageState();
}

class _SetPwdPageState extends State<SetPwdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(
              text: 'Set Up Your \nPassword'.tr,
              maxLines: null,
              softWrap: true,
              size: 36.sp,
              weight: FontWeight.w600,
              color: AppColors.color_1A342B,
            ),
            SizedBox(
              height: 115.h,
            ),
             TextField(
              decoration: InputDecoration(
                hintText: 'Enter password...'.tr,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.color_C5C5C5),
              ),
            ),
             TextField(
              decoration: InputDecoration(
                hintText: 'Enter password again...'.tr,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.color_C5C5C5),
              ),
            ),
            SizedBox(
              height: 220.h,
            ),
            ContainerTextButton(
              tapAction: () {
                Get.to(const SetNickNamePage());
              },
              bgColor: AppColors.color_65AF7C,
              width: 229,
              height: 44,
              borderRadius: 22,
              text: 'Next'.tr,
              textSize: 16,
              textWeight: FontWeight.w600,
              textColor: AppColors.color_FCF8F1,
            ).center(),
          ],
        ),
      ),
    );
  }
}
