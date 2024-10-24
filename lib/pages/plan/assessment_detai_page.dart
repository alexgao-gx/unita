import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/style/colors.dart';

class AssessmentDetailPage extends StatelessWidget {
  const AssessmentDetailPage({super.key, required this.title});
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
