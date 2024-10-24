import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/components/basic/app_bar.dart';
import 'package:unitaapp/common/index.dart';
import 'package:unitaapp/common/style/colors.dart';
import 'package:unitaapp/common/widgets/icon.dart';

class VoiceRecordPage extends StatefulWidget {
  const VoiceRecordPage({super.key});

  @override
  State<VoiceRecordPage> createState() => _VoiceRecordPageState();
}

class _VoiceRecordPageState extends State<VoiceRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Voice Record"),
      body: Column(
        children: [
          const SizedBox(
            height: 94,
          ),
          const Center(
            child: TextWidget(
              text: 'STEP 01 \nRecord the food you eat',
              color: AppColors.color_1A342B,
              size: 16,
              weight: FontWeight.w500,
              maxLines: null,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const TextWidget(
            text: 'STEP 02 \nAI Voice Recognizing',
            color: AppColors.color_1A342B,
            size: 16,
            weight: FontWeight.w500,
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          const TextWidget(
            text: 'STEP 03 \nFinalize the serving size',
            color: AppColors.color_1A342B,
            size: 16,
            weight: FontWeight.w500,
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(27),
            decoration: const BoxDecoration(
              color: AppColors.color_C1E1CE,
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
            child: IconWidget.svg(
              fit: BoxFit.cover,
              'assets/svg/ico_voice.svg',
              size: 32,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const TextWidget(
            text: 'Long press to start',
            color: AppColors.color_1A342B,
            size: 16,
            weight: FontWeight.w500,
            maxLines: null,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
