import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/user_service.dart';
import 'package:unitaapp/common/widgets/image.dart';


class MeHeader extends GetView<UserService> {
  const MeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: -60,
              child: IconWidget.svg(
                'assets/svg/me_header_bg.svg',
                fit: BoxFit.cover,
              )),
          SafeArea(
              bottom: false,
              minimum: EdgeInsets.fromLTRB(
                  14, kToolbarHeight + kMinInteractiveDimension + 30, 14, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => ImageWidget(
                        type: ImageWidgetType.network,
                        url: controller.headImageUrl,
                        fit: BoxFit.cover,
                        radius: 10,
                        width: 60,
                        height: 60,
                        placeholder: const ImageWidget.asset(
                          'assets/images/chatuser2.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => TextWidget(
                              text: 'Hey,'.trArgs([controller.username]),
                              weight: FontWeight.w700,
                              size: 24,
                              color: AppColors.color_1A342B,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            IconWidget.svg(
                              'assets/svg/mecoin.svg',
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(() => TextWidget(
                                  text: '${controller.coins}',
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.color_1A342B),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                  child: CupertinoButton(
                onPressed: () {
                  Get.toNamed(RouteNames.notificationMessages);
                },
                child: Icon(Icons.notifications_outlined, size: 20.w),
              ))),
        ],
      ),
    );
  }
}
