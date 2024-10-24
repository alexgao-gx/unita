import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/pages/home/home_page.dart';
import 'package:unitaapp/pages/log/log_page.dart';
import 'package:unitaapp/pages/me/me_page.dart';
import 'package:unitaapp/pages/plan/plan_page.dart';
import 'package:unitaapp/pages/unibot/unibot_page.dart';

class MainPage extends StatelessWidget {
  final Dio dio = Dio();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _bottomNavIndex = 0.obs;
  List<IconData> iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    LogPage(),
    UnibotPage(),
    // const Text('Plane Page'),
    // const Text('Me Page'),
    const PlanPage(),
    MePage(),
  ];

  void _onItemTapped(int index) {
    _bottomNavIndex.value = index;
  }

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // getToken('200150858200200000', 'deS8uVr*3Prg');
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Obx(() {
            return InkWell(
              child: _widgetOptions.elementAt(_bottomNavIndex.value),
              onTap: () {
                // getMsg('hello', context);
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_home_nor.png'), // Provide the path to your image asset
                  ),
                  activeIcon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_home_sel.png'), // Provide the path to your image asset
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_log_nor.png'), // Provide the path to your image asset
                  ),
                  activeIcon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_add.png'), // Provide the path to your image asset
                  ),
                  label: 'Log',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/img_unibot.png'), // Provide the path to your image asset
                  ),
                  label: 'Unibot',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_plan_nor.png'), // Provide the path to your image asset
                  ),
                  activeIcon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_plan_sel.png'), // Provide the path to your image asset
                  ),
                  label: 'Plan',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_me_nor.png'), // Provide the path to your image asset
                  ),
                  activeIcon: SizedBox(
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                    child: Image.asset(
                        'assets/images/ico_bottom_me_sel.png'), // Provide the path to your image asset
                  ),
                  label: 'Me',
                ),
              ],
              currentIndex: _bottomNavIndex.value,
              selectedItemColor: AppColors.color_456C51,
              unselectedItemColor: AppColors.color_B5C2B3,
              onTap: _onItemTapped,
            ),
            // Positioned(
            //   bottom: 28.0, // Adjust this value to position the icon vertically
            //   child: IconButton(
            //     icon: const Icon(Icons.add_circle,
            //         size: 48.0, color: Colors.blue), // Customize the icon here
            //     onPressed: () {
            //       // Add your onPressed action here
            //     },
            //   ),
            // ),
          ],
        );
      }),
    );
  }

  void showMsgDialog(context, msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getMsg(String msg, BuildContext context) async {
    Loading.show(); //popup a loading toast
    try {
      Map<String, String> myMap = {
        'message': msg,
      };
      Response response =
          await dio.post('https://www.quiznow.ai/echo', data: myMap);
      print('result==${response.data}');
      Loading.dismiss();
      Map data = response.data;
      // if (int.parse(data['status']) == 0) {
      //   BotToast.showText(text: "登陆成功");
      // } else {
      //   BotToast.showText(text: "登陆失败:${data['message']}");
      // }
      Loading.show(data['message']);
    } catch (error) {
      print('Error fetching data: $error');
      Loading.dismiss();
      // BotToast.showText(text: "请求失败:$error");
      showMsgDialog(context, '$error');
    }
  }

  Future<void> getToken(username, password) async {
    Loading.show();
    try {
      Map<String, String> myMap = {
        'appid': username,
        'password': password,
        'transid': '${username}2024040616273881234567',
      };

      Response response = await dio.get(
          'https://api.iot.10086.cn/v5/ec/get/token',
          queryParameters: myMap);
      print('result==${response.data}');
      Loading.dismiss();
      Map data = response.data;
      if (int.parse(data['status']) == 0) {
        Loading.show("登陆成功");
      } else {
        Loading.show("登陆失败:${data['message']}");
      }
    } catch (error) {
      print('Error fetching data: $error');
      Loading.dismiss();
      Loading.show("登陆失败:$error");
    }
  }

  Widget getlistView() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return;
      },
    );
  }
}
