import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';

class MePolicyPage extends StatelessWidget {
  const MePolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Policy'.tr),
      body: const Center(
        child: Text('MePolicyPage'),
      ),
    );
  }
}
