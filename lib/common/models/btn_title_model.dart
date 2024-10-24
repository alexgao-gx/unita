import 'package:get/get.dart';

class BtnTitleModel {
  final String title;
  var isSelected = false.obs;

  BtnTitleModel({required this.title, bool isSelected = false}) {
    this.isSelected.value = isSelected;
  }
}
