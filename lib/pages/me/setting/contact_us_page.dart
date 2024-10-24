import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/custom/profile_item.dart';
import 'package:unitaapp/common/index.dart';

import '../../../common/routers/names.dart';
import '../../../common/services/auth_service.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Contact Us'.tr),
      body: Column(
        children: [
          TextWidget(
            text:
                'Lorem ipsum dolor sit ame, consectetur adipiscin elit, sed do eiusmod tempor.'.tr,
            size: 28.sp,
            weight: FontWeight.w600,
            color: AppColors.color_1A342B,
            softWrap: true,
            maxLines: null,
          ),
          Divider(height: 50.h),
          _buildKVTile('Email'.tr, 'hi@unita.com'),
          _buildKVTile('Phone'.tr, '+1 917-666-8888'),
          _buildKVTile('IG'.tr, 'unita.health'),
          _buildKVTile('TikTok'.tr, 'Unita_GutHealth'),
          _buildKVTile('Fackbook'.tr, 'Unita'),
          Divider(height: 40.h),
        ],
      ).padding(left:14.w, right: 14.w, top: 18.h),
    );
  }

  Widget _buildKVTile(String key, String value) => Container(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: TextWidget(
              text: key,
              size: 16.sp,
              weight: FontWeight.w600,
              color: AppColors.color_1A342B,
            )),
        Expanded(
            flex: 5,
            child: TextWidget(
              text: value,
              size: 16.sp,
              weight: FontWeight.w600,
              color: AppColors.color_1A342B,
            )),
      ],
    ),
  );
}
