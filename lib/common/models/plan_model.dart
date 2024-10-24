import 'home_log_info.dart';

class PlanModel {
  int? currTimes;
  int? perTimes;
  int? totalTimes;
  BodyInfo? bodyInfo;
  bool? dietFlag;
  bool? herbFlag;
  List<HistoryInfo>? historyInfo;
  BodyInfo? mindInfo;

  PlanModel(
      {this.currTimes, this.perTimes, this.totalTimes,this.bodyInfo,
        this.dietFlag,
        this.herbFlag,
        this.historyInfo,
        this.mindInfo});

  PlanModel.fromJson(Map<String, dynamic> json) {
    currTimes = json['currTimes'];
    perTimes = json['perTimes'];
    totalTimes = json['totalTimes'];
    bodyInfo = json['bodyInfo'] != null
        ? new BodyInfo.fromJson(json['bodyInfo'])
        : null;
    dietFlag = json['dietFlag'];
    herbFlag = json['herbFlag'];
    if (json['historyInfo'] != null) {
      historyInfo = <HistoryInfo>[];
      json['historyInfo'].forEach((v) {
        historyInfo!.add(new HistoryInfo.fromJson(v));
      });
    }
    mindInfo = json['mindInfo'] != null
        ? new BodyInfo.fromJson(json['mindInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bodyInfo != null) {
      data['bodyInfo'] = this.bodyInfo!.toJson();
    }
    data['dietFlag'] = this.dietFlag;
    data['herbFlag'] = this.herbFlag;
    if (this.historyInfo != null) {
      data['historyInfo'] = this.historyInfo!.map((v) => v.toJson()).toList();
    }
    if (this.mindInfo != null) {
      data['mindInfo'] = this.mindInfo!.toJson();
    }
    data['currTimes'] = this.currTimes;
    data['perTimes'] = this.perTimes;
    data['totalTimes'] = this.totalTimes;
    return data;
  }
}

class BodyInfo {
  int? currTimes;
  int? perTimes;
  int? totalTimes;
  bool? newFlag;

  BodyInfo({this.currTimes, this.perTimes, this.totalTimes, this.newFlag});

  BodyInfo.fromJson(Map<String, dynamic> json) {
    currTimes = json['currTimes'];
    perTimes = json['perTimes'];
    totalTimes = json['totalTimes'];
    newFlag = json['newFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currTimes'] = this.currTimes;
    data['perTimes'] = this.perTimes;
    data['totalTimes'] = this.totalTimes;
    data['newFlag'] = this.newFlag;
    return data;
  }
}

