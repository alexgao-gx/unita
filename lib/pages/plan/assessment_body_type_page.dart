import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:unitaapp/common/models/assessment_model.dart';

class AssessmentBodyTypePage extends GetView<AssessmentBodyTypePageController> {
  const AssessmentBodyTypePage({super.key, required this.assessmentIndex, required this.data});

  final int assessmentIndex;
  final AssessmentModel data;


  @override
  String get tag => assessmentIndex.toString();

  @override
  Widget build(BuildContext context) {
    Get.put(AssessmentBodyTypePageController(),
        tag: assessmentIndex.toString());
    return const Placeholder();
  }
}

class AssessmentBodyTypePageController extends GetxController {

}
