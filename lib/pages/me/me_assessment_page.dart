import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';

class MeAssessmentPage extends StatelessWidget {
  const MeAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Assessment'.tr),
      body: const Center(
        child: Text('MeAssessmentPage'),
      ),
    );
  }
}
