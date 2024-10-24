import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Response;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/components/custom/chat_bottombar.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/services/auth_service.dart';
// import 'package:unitaapp/common/models/chatmodel.dart';
import 'package:unitaapp/common/sqlite/chat_msg.dart';
import 'package:unitaapp/common/sqlite/chat_msg_database.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';
import 'package:unitaapp/common/widgets/image.dart';

class UnibotPage extends StatelessWidget {
  UnibotPage({super.key});
  final Dio dio = Dio();
  final ScrollController _scrollController = ScrollController();
  RxList msgs = [].obs;

  @override
  Widget build(BuildContext context) {
    getHistoryMsg();
    return Scaffold(
      backgroundColor: AppColors.color_FCF8F1,
      appBar: appBar(title: "UniBot".tr),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onPanEnd: (e) {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: msgs.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatMsg model = msgs[index];
                    // if (model.isHiMsg == 1) {
                    //   return TextWidget(
                    //     text: model.receiveMsg,
                    //     color: AppColors.color_C5C5C5,
                    //     size: 12.sp,
                    //     weight: FontWeight.w400,
                    //   ).center().paddingTop(20);
                    // } else
                    if (model.isSending == 1) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 14,
                            ),
                            // IconWidget.svg(
                            //   'assets/svg/Group 753.svg',
                            //   size: 40.w,
                            // ),
                            const ImageWidget.asset(
                              'assets/images/img_unibot.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // CircularProgressIndicator(
                            //   color: AppColors.color_D7D4D0,
                            // )
                            LoadingAnimationWidget.horizontalRotatingDots(
                              color: AppColors.color_D7D4D0,
                              size: 50,
                            ),
                          ],
                        ),
                      );
                    } else if (model.sendMsg.isNotEmpty) {
                      {
                        return Container(
                          margin: const EdgeInsets.only(top: 8.0, left: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                width: 70,
                              ),
                              Expanded(
                                  child: Column(
                                // Column被Expanded包裹起来，使其内部文本可自动换行
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 13.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: TextWidget(
                                     text:  model.sendMsg,
                                      weight: FontWeight.w500,
                                      color: AppColors.color_1A342B,
                                      size: 16,
                                      maxLines: null,
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              const ImageWidget.asset(
                                'assets/images/chatuser2.jpg',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    //  else if (model.sendMsg.isNotEmpty) {
                    //   return Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Expanded(
                    //         // 使用 Expanded 包裹 Text
                    //         child: Container(
                    //           margin:
                    //               EdgeInsets.fromLTRB(74.w, 12.h, 10.w, 12.h),
                    //           padding: const EdgeInsets.all(10),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(8.0),
                    //           ),
                    //           child: Text(
                    //             model.sendMsg,
                    //             maxLines: null,
                    //             softWrap: true,
                    //             style: const TextStyle(
                    //               fontFamily: 'Fahkwang',
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.color_1A342B,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       const ImageWidget.asset(
                    //         'assets/images/chatuser.png',
                    //         width: 40,
                    //         height: 40,
                    //       ).paddingTop(12),
                    //       SizedBox(width: 14.w),
                    //     ],
                    //   );
                    // }
                    else if (model.receiveMsg.isNotEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8.0, right: 44.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              width: 14,
                            ),
                            // IconWidget.svg(
                            //   'assets/svg/Group 753.svg',
                            //   size: 40.w,
                            // ),
                            const ImageWidget.asset(
                              'assets/images/img_unibot.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 13.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.color_E0EFE1,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: TextWidget(
                                   text: model.receiveMsg,

                                    weight: FontWeight.w500,
                                    color: AppColors.color_1A342B,
                                    size: 16,
                                    maxLines: null,
                                    softWrap: true,

                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                      );
                    }
                    return null;
                    // else if (model.receiveMsg.isNotEmpty) {
                    //   return Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const SizedBox(
                    //         width: 14,
                    //       ),
                    //       // IconWidget.svg(
                    //       //   'assets/svg/Group 753.svg',
                    //       //   size: 40.w,
                    //       // ),
                    //       const ImageWidget.asset(
                    //         'assets/images/chatbot.png',
                    //         width: 40,
                    //         height: 40,
                    //       ).paddingTop(12),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       Expanded(
                    //           child: Container(
                    //         margin: const EdgeInsets.fromLTRB(10, 12, 44, 12),
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 13.w, vertical: 8.h),
                    //         decoration: BoxDecoration(
                    //           color: AppColors.color_E0EFE1,
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         child: Text(
                    //           model.receiveMsg,
                    //           maxLines: null,
                    //           style: const TextStyle(
                    //               fontFamily: 'Fahkwang',
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.color_1A342B,
                    //               fontSize: 16),
                    //         ),
                    //       ))
                    //     ],
                    //   );
                    // }
                  },
                ),
              );
            }),
            const Divider(
              height: 0.5,
              color: AppColors.color_E6DCD6,
            ),
            SizedBox(
              height: 10.h,
            ),
            ChatBottomBar(
              callBack: (value) {
                if (value == 'gained focus') {
                  // 滚动到最底部
                  debugPrint('滚动到最底部');
                  // 延时执行操作
                  scrollBottom();
                } else if (value.length >= 2) {
                  getMsg(value, context);
                  scrollBottom();
                } else {
                  Loading.show('请输入2个及以上字符');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void scrollBottom() {
    Future.delayed(const Duration(milliseconds: 500), () {
      print('Delayed operation executed');
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> getMsg(String msg, BuildContext context) async {
    // ChatModel model = ChatModel(
    //   sendMsg: msg,
    //   timStr: '2024-04-10 15:51',
    //   isSending: false,
    //   receiveMsg: null,
    //   isHiMsg: false,
    // );
    ChatMsg model = ChatMsg(
      // id: id ?? this.id,
      isSending: 0,
      isHiMsg: 0,
      sendMsg: msg,
      receiveMsg: '',
      createdTime: DateTime.now().millisecond,
    );
    msgs.add(model);
    addNote(0, 0, msg, '', DateTime.now().millisecond);

    // ChatModel sendingModel = ChatModel(
    //   sendMsg: null,
    //   timStr: '2024-04-10 15:51',
    //   isSending: true,
    //   receiveMsg: null,
    //   isHiMsg: false,
    // );

    ChatMsg sendingModel = ChatMsg(
      // id: id ?? this.id,
      isSending: 1,
      isHiMsg: 0,
      sendMsg: '',
      receiveMsg: '',
      createdTime: DateTime.now().millisecond,
    );
    msgs.add(sendingModel);
    try {
      Map<String, String> myMap = {
        'query': msg,
      };
      String idToken = Get.find<AuthService>().idToken ?? '';
      dio.options.headers['Authorization'] = 'Bearer $idToken';
      Response response =
          await dio.post('https://0iwa3nldoj.execute-api.us-west-2.amazonaws.com/prod/chatbot/chat', data: myMap);
      print('result==${response.data}');
      Map data = jsonDecode(response.data['body']);
      // BotToast.showText(text: data['message']);
      msgs.removeLast();
      // ChatModel receiveModel = ChatModel(
      //   sendMsg: null,
      //   timStr: '2024-04-10 15:51',
      //   isSending: false,
      //   receiveMsg: data['message'],
      //   isHiMsg: false,
      // );
      final receiveMsg = data['response'] ?? '';
      ChatMsg model = ChatMsg(
        // id: id ?? this.id,
        isSending: 0,
        isHiMsg: 0,
        sendMsg: '',
        receiveMsg: receiveMsg,
        createdTime: DateTime.now().millisecond,
      );
      msgs.add(model);
      addNote(0, 0, '', receiveMsg, DateTime.now().millisecond);
      scrollBottom();
    } catch (error) {
      print('Error fetching data: $error');
      Loading.show( "请求失败:$error");
      msgs.removeLast();
    }
  }

  Future addNote(isSending, isHiMsg, sendMsg, receiveMsg, createdTime) async {
    final note = ChatMsg(
      // id: id ?? this.id,
      isSending: isSending,
      isHiMsg: isHiMsg,
      sendMsg: sendMsg,
      receiveMsg: receiveMsg,
      createdTime: createdTime,
    );
    await ChatMsgDatabase.instance.create(note);
  }

  void getHistoryMsg() async {
    var notes = await ChatMsgDatabase.instance.readAllChat();
    msgs.clear();
    if (notes.isNotEmpty) {
      debugPrint('notes==${notes.length}');
      msgs.addAll(notes);
      scrollBottom();
    } else {
      ChatMsg helloMsg = ChatMsg(
        // id: id ?? this.id,
        isSending: 0,
        isHiMsg: 1,
        sendMsg: '',
        receiveMsg: 'Hi Gloria, how are you doing today?',
        createdTime: DateTime.now().millisecond,
      );
      msgs.add(helloMsg);
    }
  }
}
