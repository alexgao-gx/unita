import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/container_text_button.dart';
import 'package:unitaapp/common/components/basic/container_text_icon.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/auth_service.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/index.dart';
import 'package:unitaapp/pages/login/login_page.dart';
import 'package:unitaapp/pages/signup/create_account_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color_FFFCF5,
        centerTitle: true,
        title: ImageWidget.asset(
          'assets/images/Unita.png',
          width: 95.w,
          height: 28.h,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 75,
          ),
          IconWidget.svg(
            'assets/svg/signupbg.svg',
            width: double.infinity,
            height: 345.h,
            fit: BoxFit.cover,
          ).paddingSymmetric(horizontal: 12),
          SizedBox(
            height: 91.h,
          ),
          ContainerTextButton(
            tapAction: () {
              Get.toNamed(RouteNames.createAccount);
            },
            bgColor: AppColors.color_65AF7C,
            width: 229,
            height: 44,
            borderRadius: 22,
            text: 'Sign Up'.tr,
            textSize: 16,
            textWeight: FontWeight.w600,
            textColor: AppColors.color_FCF8F1,
          ),
          18.verticalSpace,
          ContainerTextButton(
            tapAction: () {
              Get.toNamed(RouteNames.login);
              // Get.toNamed(RouteNames.signupFlowWeight);
            },
            bgColor: AppColors.color_C1E1CE,
            width: 229,
            height: 44,
            borderRadius: 22,
            text: 'Log In'.tr,
            textSize: 16,
            textWeight: FontWeight.w600,
            textColor: AppColors.color_2F5448,
          ),
        ],
      ),
    );
  }
}
