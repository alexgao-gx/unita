import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AssessmentModel {
  String? choice;
  String? createTime;
  String? creator;
  int? id;
  String? isDeleted;
  List<AssessmentItemList>? itemList;
  String? localc;
  String? modifier;
  String? modifiyTime;
  String? navTitle;
  int? seq;
  int? tenantId;
  String? title;
  String? type;

  AssessmentModel(
      {this.choice,
        this.createTime,
        this.creator,
        this.id,
        this.isDeleted,
        this.itemList,
        this.localc,
        this.modifier,
        this.modifiyTime,
        this.navTitle,
        this.seq,
        this.tenantId,
        this.title,
        this.type});

  AssessmentModel.fromJson(Map<String, dynamic> json) {
    choice = json['choice'];
    createTime = json['createTime'];
    creator = json['creator'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    if (json['itemList'] != null) {
      itemList = <AssessmentItemList>[];
      json['itemList'].forEach((v) {
        itemList!.add(new AssessmentItemList.fromJson(v));
      });
    }
    localc = json['localc'];
    modifier = json['modifier'];
    modifiyTime = json['modifiyTime'];
    navTitle = json['navTitle'];
    seq = json['seq'];
    tenantId = json['tenantId'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['choice'] = this.choice;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    if (this.itemList != null) {
      data['itemList'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    data['localc'] = this.localc;
    data['modifier'] = this.modifier;
    data['modifiyTime'] = this.modifiyTime;
    data['navTitle'] = this.navTitle;
    data['seq'] = this.seq;
    data['tenantId'] = this.tenantId;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}

class AssessmentItemList {
  int? assessmentId;
  String? category;
  String? createTime;
  String? creator;
  int? id;
  String? isDeleted;
  String? localc;
  String? modifier;
  String? modifiyTime;
  String? subTitle;
  int? tenantId;
  String? title;
  String? value;
  RxBool isSelected = false.obs;

  AssessmentItemList(
      {this.assessmentId,
        this.category,
        this.createTime,
        this.creator,
        this.id,
        this.isDeleted,
        this.localc,
        this.modifier,
        this.modifiyTime,
        this.subTitle,
        this.tenantId,
        this.title,
        this.value});

  AssessmentItemList.fromJson(Map<String, dynamic> json) {
    assessmentId = json['assessmentId'];
    category = json['category'];
    createTime = json['createTime'];
    creator = json['creator'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    localc = json['localc'];
    modifier = json['modifier'];
    modifiyTime = json['modifiyTime'];
    subTitle = json['subTitle'];
    tenantId = json['tenantId'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assessmentId'] = this.assessmentId;
    data['category'] = this.category;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['localc'] = this.localc;
    data['modifier'] = this.modifier;
    data['modifiyTime'] = this.modifiyTime;
    data['subTitle'] = this.subTitle;
    data['tenantId'] = this.tenantId;
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}
