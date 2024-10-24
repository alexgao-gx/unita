import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/style/colors.dart';

class PlanDetailPage extends StatelessWidget {
  const PlanDetailPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: title),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
