import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:unitaapp/common/api/user_api.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';

import '../../../common/models/message_model.dart';

class NotificationMessagesPage
    extends GetView<NotificationMessagesPageController> {
  const NotificationMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationMessagesPageController());
    return Scaffold(
      appBar: appBar(title: 'Notifications'.tr),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.fetchMessages,
        onLoading: controller.loadMoreMessages,
        enablePullUp: true,
        child: Obx(
                () => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                itemBuilder: (_, index) =>
                    _buildMessageItem(controller.messagesRx[index]),
                separatorBuilder: (_, __) => 10.verticalSpace,
                itemCount: controller.messagesRx.length)
        ),
      ),
    );
  }

  Widget _buildMessageItem(MessageModel data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(
                text: data.title ?? '',
                size: 15.sp,
                weight: FontWeight.w600,
                color: AppColors.color_1A342B,
                softWrap: true,
               maxLines: null,
              ).expanded(),
              TextWidget(
                text: DateUtil.formatDateStr(
                    data.createTime ?? DateTime.now().toString(),
                    format: DateFormats.y_mo_d),
                size: 14.sp,
                weight: FontWeight.w400,
                color: AppColors.color_1A342B,

              )
            ],
          ),
          10.verticalSpace,
          TextWidget(
            text: data.content ?? '',
            size: 14.sp,
            weight: FontWeight.w400,
            color: AppColors.color_1A342B,
            softWrap: true,
            maxLines: null,
            // overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class NotificationMessagesPageController extends GetxController {
  RxList<MessageModel> messagesRx = <MessageModel>[].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool isLoading = false;
  int page = 1; // 当前页数

  @override
  void onInit() {
    fetchMessages();
    super.onInit();
  }

  Future<void> fetchMessages() async {
    if (isLoading) return; // 防止重复请求
    isLoading = true;
    page = 1; // 刷新时重置为第一页
    try {
      var messages = await UserAPI.fetchNotifications(page: page); // 传递当前页数
      messagesRx.value = messages;
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    } finally {
      isLoading = false;
    }
  }

  Future<void> loadMoreMessages() async {
    if (isLoading) return; // 防止重复请求
    isLoading = true;
    try {
      var moreMessages =
          await UserAPI.fetchNotifications(page: ++page); // 增加页数并请求
      if (moreMessages.isNotEmpty) {
        messagesRx.addAll(moreMessages); // 添加更多消息
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData(); // 没有更多数据时
      }
    } catch (e) {
      refreshController.loadFailed();
    } finally {
      isLoading = false;
    }
  }
}
