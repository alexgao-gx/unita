import 'package:flutter/material.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';

class MeAboutPage extends StatelessWidget {
  const MeAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'About'),
      body: const Center(
        child: Text('MeAboutPage'),
      ),
    );
  }
}
