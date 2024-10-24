import 'package:get/get.dart';

class AssessmentPageModel {
  String? navTitle;
  String? title;
  String? choice;
  String? icon;
  List<AssessmentOptionModel>? itemList;

  AssessmentPageModel(
      {this.navTitle, this.title, this.choice, this.icon, this.itemList});

  AssessmentPageModel.fromJson(Map<String, dynamic> json) {
    navTitle = json['navTitle'];
    title = json['title'];
    choice = json['choice'];
    icon = json['icon'];
    if (json['itemList'] != null) {
      itemList = <AssessmentOptionModel>[];
      json['itemList'].forEach((v) {
        itemList!.add(new AssessmentOptionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['navTitle'] = this.navTitle;
    data['title'] = this.title;
    data['choice'] = this.choice;
    data['icon'] = this.icon;
    if (this.itemList != null) {
      data['itemList'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssessmentOptionModel {
  String? type;
  String? title;
  String? value;
  RxBool isSelected = false.obs;

  AssessmentOptionModel(
      {this.type,
        this.title,
        this.value});

  AssessmentOptionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    value = json['value'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}
