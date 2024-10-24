import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/text.dart';

import '../../common/components/basic/loading_button.dart';

class SignupFlowDonePage<T extends SignupFlowDonePageController>
    extends GetView<SignupFlowDonePageController> {
  SignupFlowDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupFlowDonePageController());
    return Scaffold(
      appBar: appBar(elevation: 0,actions: [
        CupertinoButton(
            child: IconWidget.svg('assets/svg/ico_info.svg', size: 14),
            onPressed: () {
              Get.dialog(UniCoinsDialog(),
                  barrierColor: Colors.black45,
                  transitionDuration: Duration(milliseconds: 200));
            }),
        UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: CupertinoButton(
              color: AppColors.color_C1E1CE,
              borderRadius: BorderRadius.circular(50),
              padding: EdgeInsets.fromLTRB(10, 3, 2, 3),
              minSize: 25,
              child: Row(
                children: [
                  TextWidget(
                    text: '1/5',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.color_1A342B),
                  ),
                  SizedBox(width: 5),
                  IconWidget.svg('assets/svg/ico_coins.svg', size: 21),
                ],
              ),
              onPressed: () {
                Get.dialog(UniCoinsDialog(),
                    barrierColor: Colors.black45,
                    transitionDuration: Duration(milliseconds: 200));
              }),
        ),
        SizedBox(width: 10),
      ]),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 TextWidget(
                  text:
                      "Start Your Health \nJourney With Unita, Act \n& Get Reward!".tr,
                  maxLines: null,
                  softWrap: true,
                  size: 28,
                  weight: FontWeight.w600,
                  color: AppColors.color_1A342B,
                ),
                Expanded(
                    child: Transform(
                  transform: Matrix4.translationValues(0.0, -30.h, 0.0),
                  child: IconWidget.svg(
                    'assets/svg/img_journey.svg',
                    fit: BoxFit.contain,
                  ),
                ))
              ])),
      bottomNavigationBar: LoadingButton<T>(
          text: 'Unlock Your Health'.tr,
          padding: EdgeInsets.symmetric(horizontal: 73, vertical: 20),
          onPressed: () {
            Get.offAllNamed(RouteNames.main);
          }),
    );
  }
}

class UniCoinsDialog extends StatelessWidget {
  UniCoinsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 44),
          decoration: BoxDecoration(
              color: AppColors.color_D9D9D9,
              borderRadius: BorderRadius.circular(14)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextWidget(
                    text: 'UniCoin'.tr,
                    textAlign: TextAlign.center,
                    size: 16,
                    weight: FontWeight.w600,
                    color: AppColors.color_1A342B),
                Divider(height: 36, thickness: 0.5),
                _buildKVTile('What is Unicoin?'.tr,
                    'UniCoin serves as a reward token incentivizing active app usage and engagement.'.tr),
                SizedBox(height: 23),
                _buildKVTile('How to earn Unicoin?'.tr,
                    'You can earn UniCoin by completing Assessments, Logging your daily, and engaging in personalized health plans.'.tr),
                SizedBox(height: 23),
                _buildKVTile('What are Unicoin for?'.tr,
                    'UniCoin can offer more AI functions, serve as discounts, gifts, and reward. More detail information coming soon.'.tr),
                Divider(height: 36, thickness: 0.5),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 10,
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: TextWidget(
                        text: 'Close'.tr,
                        size: 16,
                        weight: FontWeight.w600,
                        color: AppColors.color_65AF7C))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKVTile(String title, String content) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextWidget(
              text: title,
              size: 16,
              weight: FontWeight.w600,
              color: AppColors.color_1A342B),
          TextWidget(
              text: content,
              softWrap: true,
              overflow: TextOverflow.visible,
              maxLines: null,
              style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color_1A342B)),
        ],
      );
}

class SignupFlowDonePageController extends LoadingButtonController {
  @override
  bool loadingButtonEnabled() => true;

  @override
  Future<bool> onLoadingButtonPressed() async {
    Get.find<UserService>().fetchUserInfo();
    return false;
  }
}
